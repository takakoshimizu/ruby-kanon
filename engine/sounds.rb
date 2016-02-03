require 'rubygems'
require 'gosu'

module Engine
  class Sounds   
    def initialize(window)
      @window = window
      @sounds = Hash.new(nil)
    end
    
    def clear_sounds
      @sounds = Hash.new(nil)
    end
    
    def add_sound(varname, soundfile)
      @sounds[varname] = Gosu::Sample.new(@window, soundfile)
    end
    
    def play_sound(varname)
      @sounds[varname].play
    end
  end
  
  class Music  
    def initialize(window)
      @window = window
      @music = Hash.new(nil)
    end
    
    def clear_music
      @music.each {|m| m[1].stop if m[1].playing? }
      @music = Hash.new(nil)
    end
    
    def add_music(varname, musicfile)
      @music[varname] = Gosu::Song.new(@window, 
        "resources/music/#{musicfile}.ogg")
    end
    
    def play_music(varname)
      @music[varname].play
    end
    
    def stop_music(varname)
      @music[varname].stop if @music[varname].playing?
    end
  end
end