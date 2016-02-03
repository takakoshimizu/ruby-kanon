module Functions
  FUNCTIONS = {
    :set_background => 'graphics',
    :show_graphic   => 'graphics',
    :init_image     => 'graphics',
    :display_image  => 'graphics',
    :hide_image     => 'graphics',
    :hide           => 'graphics',
    :jump_image     => 'graphics',
    :pan_image      => 'graphics',
    :play_music     => 'music',
    :clear_music    => 'music'
  }
  def method_missing(m, *args)
    # must go to one of the modules, let's figure out which
    case FUNCTIONS[m.to_s.to_sym]
      when 'graphics'
        @graphics.send(m, *args)
      when 'music'
        @music.send(m, *args)
      when 'sound'
        @sound.send(m, *args)
      else
        raise "method missing: #{m.to_s}"
    end
  end

  def flush_graphics
    @graphics.flush
    @clickables = Array.new
    @music.clear_music
  end

  def show_graphic(position, character, mood)
    @graphics.show(position, character, mood)
  end

  # Sets the window caption
  def set_caption=(other)
    self.caption = other
  end

  # Creates a clickable area.
  def create_clickable(varname, action)
    img = @graphics.get_image(varname)
    @clickables << ClickableArea.new(img, action)
  end

  # Creates a new music file
  def create_music(varname, filename)
    @music.add_music(varname, filename)
  end

  # wait a specified number of seconds
  def wait(seconds)
    @waiting = seconds * 1000
  end

  # Exits the doohicky
  def do_exit
    @music.clear_music
    Kernel::exit(0)
  end

  # Clears the screen
  def nvl_clear
    @script.clear
  end
end
