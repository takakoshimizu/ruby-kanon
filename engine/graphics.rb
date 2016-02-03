require 'rubygems'
require 'gosu'
require './engine/image'

module Engine
  class Graphics

    HIDE, DISPLAY, MIX = 1..3

    def initialize(window)
      @window = window
      @hidden = false
      @background = nil
      @ready = false
      @text_panel = Gosu::Image.new(@window, "resources/text_panel.png", true)
      @mouse = Gosu::Image.new(@window, "resources/mouse.png", true)
      @graphics = {:left => nil, :center => nil, :right => nil, :mix => nil}
      @positions = {:left => 150, :center => 400, :right => 650}
      @images = Hash.new
    end

    def set_background(file)
      @background = [Gosu::Image.new(@window,
          "resources/#{file}.png", true),
          0, Graphics::DISPLAY]
      @ready = false
    end

    def show(position, character, mood)
      if @graphics[position.to_sym] != nil then
        # MIX time!
        @graphics[:mix] = [Gosu::Image.new(@window,
                "resources/#{character}/#{mood}.png", false),
                0, Graphics::DISPLAY, position.to_sym]
        @graphics[position.to_sym][2] = Graphics::HIDE
        @ready = false
      else
        @ready = false
        @graphics[position.to_sym] = [Gosu::Image.new(@window,
                "resources/#{character}/#{mood}.png", false),
                0, Graphics::DISPLAY]
      end
    end

    def init_image(varname, file, x, y, visible)
      @images[varname] = Image.new(@window, file, false, x, y, visible)
    end

    def display_image(varname, time)
      @images[varname].show(time)
    end

    def hide_image(varname, time)
      @images[varname].hide(time)
    end

    def jump_image(varname, x, y)
      @images[varname].jump_to(x, y)
    end

    def pan_image(varname, x, y, time)
      @images[varname].pan_to(x, y, time)
    end

    def get_image(varname)
      return @images[varname]
    end

    def hide(position)
      @graphics[position.to_sym][2] = Graphics::HIDE
    end

    def ready?
      return @ready
    end

    def hide_frame
      @hidden = !@hidden
    end

    def flush
      @graphics[:left] = nil
      @graphics[:right] = nil
      @graphics[:center] = nil
      @images = Hash.new
    end

    def draw
      @images.keys.each do |i|
        @images[i].update
        @images[i].draw
      end
      if @background then
        @background[0].draw(0, 0, 0, 1, 1, "#{dec2hex(@background[1].to_s)}FFFFFF".to_i(16))
        if @background[2] == DISPLAY and @background[1] != 255 then
          @background[1] += 15
          @ready = true if @background[1] == 255
        elsif @background[2] == HIDE and @background[1] != 0 then
          @background[1] -= 15
          @ready = true if @background[1] == 0
        end
      end
      @graphics.each do |pos, g|
        if g then
          if pos == :mix then
            if g[1] == 255 and @graphics[g[3]][1] == 0 then
              # mixing complete
              @graphics[g[3]] = [g[0],g[1],g[2]]
              @graphics[:mix] = nil
            end
            pos = g[3]
          end
          g[0].draw(@positions[pos] - (g[0].width / 2), 600 - g[0].height, 2, 1, 1, "#{dec2hex(g[1].to_s)}FFFFFF".to_i(16))
          if g[2] == DISPLAY and g[1] != 255 then
            g[1] += 15
            @ready = true if g[1] == 255
          elsif g[2] == HIDE and g[1] != 0 then
            g[1] -= 15
            @ready = true if g[1] == 0
          end
        end
      end
      @text_panel.draw(50, 50, 5) if !@hidden
      @mouse.draw(@window.mouse_x, @window.mouse_y, 20)
    end

    def dec2hex(number)
       number = Integer(number);
       hex_digit = "0123456789ABCDEF".split(//);
       ret_hex = '';
       while(number != 0)
          ret_hex = String(hex_digit[number % 16 ] ) + ret_hex;
          number = number / 16;
       end
       return ret_hex; ## Returning HEX
    end
  end
end
