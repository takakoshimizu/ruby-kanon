require 'rubygems'
require 'gosu'

module Engine
  class Script
    TEXT_WIDTH = 680
    START_X, START_Y = 60, 60
    FONT_HEIGHT = 26
    # Creates a new script container
    def initialize(window)
      # @lines is an array of strings
      @lines = Array.new
      @current_pos = 0
      @current = true
      @hidden = false
      @cur_start_y = START_Y
      @font = Gosu::Font.new(window, Gosu::default_font_name, FONT_HEIGHT)
      @ctc = Gosu::Image.load_tiles(window, "resources/sakura.png", 20, 20, false)
    end

    # adds a new line of script
    def append_line(line)
      @lines.push(line)
      @current = false
      @current_pos = 0
    end

    # does the script want more input yet?
    def wants_script?
      return @current
    end

    # force the script to be current to accept input
    def force_current
      @current = true
    end

    # clears the current page
    def clear
      @lines.clear
    end

    def hide_all
      @hidden = !@hidden
    end

    # advances the last line of script
    def advance
      return if @current or @hidden
      @current_pos += 1.5
      if @current_pos >= @lines.last.length then
        @current = true
      end
    end
    
    def find_line_length(line)
      new_lines = Array.new
      new_words = Array.new
      words = line.split(/ /)
      words.each_index do |i|
        word = words[i]
        new_words.push(word)
        if @font.text_width(new_words.join(" ")) > TEXT_WIDTH then
          new_words.pop
          width = 0
          new_lines.push(new_words.join(" "))
          new_words.clear
        else
          new_words.pop
        end
        new_words.push(word)
        new_lines.push(new_words.join(" ")) if i == (words.length - 1)
      end
      new_lines
    end

    # draws the current screen of text
    def draw
      return if @hidden
      cur_y = @cur_start_y
      @lines.each do |line|
        if cur_y >= (600 - START_Y - FONT_HEIGHT) then
          newline = find_line_length(@lines.shift)
          if newline.length > 1 then
            @lines.unshift(newline[1..-1].join(" "))
          else
            if @cur_start_y != START_Y then
              @cur_start_y = START_Y
            else
              @cur_start_y = START_Y + FONT_HEIGHT
            end
          end
        end
        
        line = line[0, @current_pos] if line == @lines.last and !@current
        width = @font.text_width(line)
        if width.to_i >= TEXT_WIDTH then
          # now break down each segment~
          # try to find a word break if possible
          new_lines = find_line_length(line)
          new_lines.each do |l|
            if cur_y >= (600 - START_Y - FONT_HEIGHT) then
              newline = find_line_length(@lines.shift)
              if newline.length > 1 then
                @lines.unshift(newline[1..-1].join(" "))
              else
                if @cur_start_y != START_Y then
                  @cur_start_y = START_Y
                else
                  @cur_start_y = START_Y + FONT_HEIGHT
                end
              end
            end
            
            @font.draw(l, START_X, cur_y, 9)
            cur_y += FONT_HEIGHT
            cur_y += FONT_HEIGHT if l == new_lines.last
          end
        else          
          @font.draw(line, START_X, cur_y, 9)
          cur_y += FONT_HEIGHT * 2
        end
      end
      if @current then
        # draw CTC indicator
        img = @ctc[Gosu::milliseconds / 150 % @ctc.size];
        img.draw(720, 520, 10)
      end
    end
  end
end