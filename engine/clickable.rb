module Engine
  class ClickableArea
    
    attr_reader :x, :y, :width, :height, :active, :action
    
    def initialize(x, y, width, height, action)
      @x, @y, @width, @height = x, y, width, height
      @active = true
      @action = action
    end
    
    def initialize(image, action)
      @x, @y = image.x, image.y
      @width, @height = image.image.width, image.image.height
      @active = true
      @action = action
    end
    
    def is_active?
      return true
    end
    
    def is_clicked?(x, y)
      return if !is_active?
      # collision testing is retarded. At least it's a rectangle.
      if x > @x and y > @y and x < (@x + @width) and y < (@y + @height) then
        puts "Collided"
        return true
      end
      return false
    end
  end
end