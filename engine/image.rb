require 'rubygems'
require 'gosu'

module Engine
  class Image

    attr_reader :x, :y

    # Creates a new image with a location of x,y and a
    # draw order of z
    def initialize(window, resource, hard_borders, x, y, vis)
      @window = window
      @showing, @hiding = false, false
      @pan = {:from => [0,0], :to => [0,0], :time => 0.0, :active => false}
      @last_time = 0
      @image = "resources/#{resource}.png"
      @x, @y = x, y
      # Defer loading of the image UNTIL it's needed.
      if vis then
        @image = Gosu::Image.new(@window, @image, hard_borders)
      end
      @alpha = if vis then
        255
      else
        0
      end
    end

    # custom image getter to support lazy loading
    def image
      if @image.is_a? String then
        @image = Gosu::Image.new(@window, @image, false)
      end
      return @image
    end

    # fades in an image in _time_ seconds
    def show(time)
      if @image.is_a? String then
        @image = Gosu::Image.new(@window, @image , false)
      end
      @showing = true
      @last_time = Gosu::milliseconds
      @time = time * 1000
      @alpha = @alpha + 1
    end

    # fades out an image in _time_ seconds
    def hide(time)
      @hiding = true
      @last_time = Gosu::milliseconds
      @time = time * 1000
      @alpha = 254
    end

    # pans an image to a certain location in
    # _time_ seconds
    def pan_to(x, y, time)
      @pan[:from] = [@x, @y]
      @pan[:to] = [x, y]
      @pan[:time] = time * 1000
      @pan[:active] = true
    end

    # jumps the image to a certain location instantly
    def jump_to(x, y)
      @x, @y = x, y
    end

    # updates the alpha of an image and handles
    # panning distances
    def update
      return nil if !@pan[:active] and !(@hiding or @showing)

      new_time = Gosu::milliseconds

      # determine amount to fade in since last frame
      if @showing or @hiding then
        if @time > 0 then
          fade = ((new_time - @last_time).to_f / @time.to_f) * 255
        else
          fade = 255
        end
        if @showing then
          @alpha = @alpha + fade
          if @alpha.to_i >= 255 then
            @alpha = 255
            @showing = false
          end
        else
          @alpha = @alpha - fade
          if @alpha.to_i <= 0 then
            @alpha = 0
            @hiding = false
          end
        end
      end

      # now handle pan movement
      if @pan[:active] then
        x_dist = -(((new_time - @last_time).to_f / @pan[:time].to_f) *
        (@pan[:from][0] - @pan[:to][0]).to_i)
        y_dist = -(((new_time - @last_time).to_f / @pan[:time].to_f) *
        (@pan[:from][1] - @pan[:to][1]).to_i)
        @x = @x + x_dist
        @y = @y + y_dist
        if @x.to_i == @pan[:to][0] and @y.to_i == @pan[:to][1] then
          @pan[:active] = false
        end
      end
      @last_time = new_time
    end

    # draws the image
    def draw
      return if @image.is_a? String
      return if @alpha == 0
      @image.draw(@x.to_i, @y.to_i, 4, 1, 1, "#{dec2hex(@alpha.to_i)}FFFFFF".to_i(16))
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