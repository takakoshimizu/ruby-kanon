require 'rubygems'
require 'gosu'
require './engine/image'
require './engine/script'
require './engine/scriptreader'
require './engine/graphics'
require './engine/functions'
require './engine/clickable'
require './engine/sounds'

# THIS SHIT IS NOW REPOSITORIFIED!
module Engine
  class Engine < Gosu::Window

    # include shit keeps this file from getting too damn crowded
    include Functions

    # Initialize creates the window and sets a default caption
    # this will be overwritten once the script begins
    # execution. 800x600 is the only size, too bad.
    def initialize(scene)
      super(800,600, false)
      self.caption = "Ruby Ren'ai Game Engine"
      @hidden = false
      @script = Script.new(self)
      @graphics = Graphics.new(self)
      @clickables = Array.new
      @music = Music.new(self)
      @scriptreader = ScriptReader.new(self, scene || "mainmenu")
      @time = Gosu::milliseconds
      advance
    end

    # advances the current script line character by character.
    def update
      if button_down? Gosu::Button::KbEscape then
        do_exit
      end
      if @waiting then
        @waiting = @waiting - (Gosu::milliseconds - @time)
        @time = Gosu::milliseconds
        if @waiting.to_i <= 0 then
          @waiting = nil
          advance
        end
        return
      end
      @script.advance
    end

    # Draws the current batch of images + text
    def draw
      @graphics.draw
      @script.draw
    end

    # handles clicks/enters
    def button_up(id)
      return if !@graphics.ready?
      if id == Gosu::Button::MsLeft or id == Gosu::Button::KbReturn then
        if @hidden then
          # process clickins
          @clickables.each do |clickable|
            if clickable.is_clicked?(self.mouse_x, self.mouse_y) then
              toggle_frame
              @script.force_current
              @scriptreader = ScriptReader.new(self, clickable.action)
              advance
            end
          end
          return
        end
        advance
      elsif id == Gosu::Button::MsRight or id == Gosu::Button::KbSpace then
        toggle_frame unless @script_induced
      end
    end

    # toggles the text frame on and off
    # locks it if the script is what caused this
    def toggle_frame(script_induced = false)
      @script.hide_all
      @graphics.hide_frame
      @hidden = !@hidden
      @script_induced = script_induced if @hidden
      @script_induced = false if !@hidden
    end

    # Advances the script each click
    def advance
      if @script.wants_script? then
        line = @scriptreader.advance_script
        self.do_exit if line == nil
        return if line == ""
        @script.append_line(line)
      else
        @script.force_current
      end
    end
  end
end
