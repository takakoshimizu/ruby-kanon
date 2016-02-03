module Engine

  # class to govern the creation of the right kind of command
  class CommandBuilder
    def self.create(window, command, options)
      case command
      when "show"
        return ShowCommand.new(window, command, options)
      when "hide"
        return HideCommand.new(window, command, options)
      when "caption"
        return CaptionCommand.new(window, command, options)
      when "nvl"
        return NvlCommand.new(window, command, options)
      when "scene" then
        return SceneCommand.new(window, command, options)
      when "display"
        return DisplayCommand.new(window, command, options)
      when "undisplay"
        return UndisplayCommand.new(window, command, options)
      when "pan"
        return PanCommand.new(window, command, options)
      when "jump"
        return JumpCommand.new(window, command, options)
      when "play"
        return PlayCommand.new(window, command, options)
      when "wait"
        return WaitCommand.new(window, command, options)
      when "exit" then
        return ExitCommand.new(window, command, options)
      when "toggle" then
        return FrameCommand.new(window, nil, nil)
      else
        return DialogueCommand.new(window, command, options)
      end
    end
  end

  # base command class
  class Command
    def initialize(window, command, options)
      @window, @command, @options = window, command, options
    end

    def execute
      # plz override this
    end
  end

  # Subclass for Dialogue
  class DialogueCommand < Command
    def execute
      @options.gsub!(/\-\-/, "ー")
      if @command == "Narrator" then
        return ["say", @options[1..-2]]     # strips quotes for narrator
      else
        return ["say", "#{@command}  「 #{@options[1..-2].strip} 」"]
      end
    end
  end

  # Subclass for a show command
  class ShowCommand < Command
    def execute
      @options = @options.split(/ /)
      @window.show_graphic(@options[0], @options[1], @options[2])
    end
  end

  # Subclass for a hide command
  class HideCommand < Command
    def execute
      @window.hide(@options)
    end
  end

  # subclass for a caption command
  class CaptionCommand < Command
    def execute
      @window.set_caption = @options[1..-2]
    end
  end

  # Subclass for a NVL action command
  class NvlCommand < Command
    def execute
      @window.nvl_clear if @options == "clear"
    end
  end


  # Subclass for a Scene command
  class SceneCommand < Command
    def execute
      return ['scene', @options]
    end
  end

  # subclass for a display command
  class DisplayCommand < Command
    def execute
      opts = @options.split(/ /)
      @window.display_image(opts[0], opts[1].to_f)
    end
  end

  # subclass for an undisplay command
  class UndisplayCommand < Command
    def execute
      opts = @options.split(/ /)
      @window.hide_image(opts[0], opts[1].to_f)
    end
  end

  # subclass for a pan cmmand
  class PanCommand < Command
    def execute
      opts = @options.split(/ /)
      @window.pan_image(opts[0], opts[1].to_i, opts[2].to_i, opts[3].to_f)
    end
  end

  # subclass for a jump command
  class JumpCommand < Command
    def execute
      opts = @options.split(/ /)
      @window.jump_image(opts[0], opts[1].to_i, opts[2].to_i)
    end
  end

  # subclass for a play command
  class PlayCommand < Command
    def execute
      opts = @options.split(/ /)
      @window.play_music(opts[0])
    end
  end

  # Subclass for a wait command
  class WaitCommand < Command
    def execute
      @window.wait(@options.to_f)
      return "wait"
    end
  end

  # subclass for a frame command
  class FrameCommand < Command
    def execute
      @window.toggle_frame(true)
    end
  end

  # subclass for an exit command
  class ExitCommand < Command
    def execute
      puts "Exiting."
      @window.do_exit
    end
  end
end