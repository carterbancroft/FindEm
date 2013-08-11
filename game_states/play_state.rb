$game_started = false

class PlayState < Chingu::GameState
    traits :timer
    def initialize(options = {})
        super

        self.input = [
            :released_left_mouse_button => :released_left_mouse_button, 
            :s => :start_turn,
            :e => :end_turn
        ]
        @level = options[:level]
        @rows = options[:rows]
        @columns = options[:columns]
        
        for i in 1..@rows
            for j in 1..@columns
                xPos = j*90
                yPos = i*90
                margin = 20

                Block.create(:x => xPos+margin, :y => yPos+margin)
            end
        end

        #ResetButton.create(:x => 600, :y => 100)

        Block.all.each do |block|
            during(2500) {}.then {
                block.text.destroy
                block.flip = true
            }
        end
    end

    def released_left_mouse_button
    end

	def update
    	super

		if $game_started && @first_block == nil
            Block.all.each do |block|
                if block.is_flipped?
                    @first_block = block
					puts @first_block.text.text
				end
            end
        end
	end

    def start_turn 
        $game_started = false
        @first_block = nil
        Block.all.each do |block|
			block.destroy
		end
		
		push_game_state(PlayState.new(:level => @level+1, :rows => @rows+1, :columns => @columns+1))
    end

    def end_turn
        unflipped_blocks = []
        Block.all.each do |block|
            unless block.is_flipped?
                unflipped_blocks << block
                block.flip = true
            end
            
		    unless @first_block == nil	
				if block.text.text == @first_block.text.text
					block.text.color = Color::BLUE
				else
					block.text.color = Color::RED
				end
			end
        end

        unflipped_blocks.each do |block|
            if block.text.text == @first_block.text.text
                block.text.color = Color::GREEN
            end
        end
    end
end 
