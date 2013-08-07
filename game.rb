require 'rubygems'
$LOAD_PATH.unshift File.join(File.expand_path(__FILE__), "..", "..", "lib")
require 'chingu'
include Gosu
include Chingu

require './game_objects/block.rb'
require './game_objects/reset_button.rb'
require './game_states/play_state.rb'

class Game < Chingu::Window
    def initialize
        super
        retrofy
        @factor = 3
        @input = { :escape => :exit }
        @cursor = Gosu::Image.new(self, 'media/mouse.png')
    
        push_game_state(PlayState.new)
    end

    def draw
        super

        @cursor.draw(self.mouse_x, self.mouse_y, 100)
    end

    def needs_cursor?
        false
    end
end
