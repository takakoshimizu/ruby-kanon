require './engine/commands'

module Engine
  class ScriptReader

    attr_reader :characters

    def initialize(window, file)
      @window = window
      @window.flush_graphics
      @window.nvl_clear
      script = File.readlines("scripts/#{file}.rb").collect! {
        |l| l.strip
      }.delete_if {
        |l| l.length == 0
      }.delete_if {
        |l| l =~ /^#/
      }
      script_start = script.find{ |l| l == "scene:" }
      script_start = script.index(script_start)
      inits = script[1..script_start-1]
      @script = script[script_start+1..-1]

      @characters = Hash.new

      # refactored init segment
      inits.each do |i|
        l = i.split(/ /)
        case l[0]
        when "background"
          @window.set_background(l[1][1..-2])
        when "character"
          c = i.scan(/\w+/)
          @characters[c[1].to_s] = c[2..-1].collect { |l| l.to_s }
        when "image"
          @window.init_image(l[1], l[2][1..-2],
            l[3].to_i, l[4].to_i,
            l[5] == "visible")
        when "sound"
          # do nothing yet
        when "music"
          @window.create_music(l[1], l[2][1..-2])
        when "clickable"
          @window.create_clickable(l[1], l[2])
        end
      end

      tscript = Array.new
      pline = nil
      @script.each do |line|
        l = Hash.new
        line = line.split(/ /)
        if !pline then
          l[:command] = line[0]
          l[:options] = line[1..-1].join(" ")
        else
          l[:command] = pline[:command]
          l[:options] = "\"" + pline[:options][1..-3] + line.join(" ")[1..-2].chomp + "\""
          pline = nil
        end
        if line[-1] == "_" then
          pline = {:command => l[:command], :options => l[:options][0..-2].chomp }
          next
        end
        return if check_errors(l, line)
        tscript << CommandBuilder.create(@window, l[:command], l[:options])
      end
      @script = tscript
    end

    # returns the remaining lines in the script
    def lines
      return @script.length
    end

    # returns the next line of displayable script, or
    # otherwise performs the actions required
    def advance_script
      # even more refactored command execution
      line = @script.shift
      ret = line.execute
      if ret == "exit" then
        puts "EXITING"
        return nil
      elsif ret == "wait" then
        return ""
      elsif ret.is_a? Array
        if ret[0] == "scene" then
          @window.nvl_clear
          initialize(@window, ret[1])
        elsif ret[0] == "say" then
          return ret[1]
        end
      end
      self.advance_script
    end

    # checks the script line for errors
    def check_errors(l, full_line)
      if !COMMANDS.include? l[:command] then
        # if it's not a command, it has to be a character
        if !@characters.keys.include? l[:command] then
          # and if it's not then there's a problem
          show_error(INVALID_COMMAND, l[:command], full_line)
          return -1
        end
      elsif l[:command] == "show" then
        # if it's a show command, then the character and mood
        # must be correct
        opts = l[:options].split(/ /)
        if !%w{left center right}.include? opts[0] then
          show_error(INVALID_POSITION, opts[0], full_line)
          return -1
        elsif !@characters.keys.include? opts[1] then
          show_error(INVALID_CHARACTER, opts[1], full_line)
          return -1
        elsif !@characters[opts[1]].include? opts[2] then
          show_error(INVALID_MOOD, opts[2], full_line)
          return -1
        end
      end
      return nil
    end

    def show_error(error, command, full_line)
      error[1][/\%s/] = command
      puts "Error #{error[0]}:"
      puts error[1]
      puts "on line:"
      puts full_line.join(" ")
    end

    COMMANDS = %w{ show hide caption nvl scene exit display undisplay jump pan toggle play wait }
    INVALID_COMMAND = ["SCR01","The command '%s' is invalid, or is an undefined character."]
    INVALID_POSITION = ["SCR02", "The position '%s' is invalid. Please use left, right, or center."]
    INVALID_CHARACTER = ["SCR03", "The character '%s' has not been defined for use."]
    INVALID_MOOD = ["SCR03", "The mood '%s' has not been defined for that character."]

  end
end
