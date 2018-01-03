require 'studio_game/player'
module StudioGame
	describe Player do |variable|

		before do |variable|
			@initial_health = 150
			@player = Player.new("larry", @initial_health)
		end
		before do |variable|
			$stdout = StringIO.new
		end
		it "has a capitalized name" do
			expect(@player.name).to eq ("Larry")
		end
		it "has an initial health" do |variable|
			expect(@player.health).to eq (150)
		end
		it "has a string representation" do |variable|
			@player.found_treasure(Treasure.new(:hammer, 50))
	  		@player.found_treasure(Treasure.new(:hammer, 50))
			expect(@player.to_s).to eq ("I'm Larry with a health = 150 and a score = 250.")
		end
		it "computes a score as the sum of its health and length of name" do |variable|
			@player.found_treasure(Treasure.new(:hammer, 50))
	  		@player.found_treasure(Treasure.new(:hammer, 50))
			expect(@player.score).to eq (250)
		end
		it "increases health by 15 when w00ted" do |variable|
			@player.w00t

			expect(@player.health).to eq (@initial_health + 15)
		end
		it "decreases health by 10 when blammed" do |variable|
			@player.blam

			expect(@player.health).to eq (@initial_health - 10)
		end
		context "with a health greater than 100" do |variable|
			before do |variable|
				@player = Player.new("larry", 150)
			end

			it "is strong" do |variable|
				expect(@player).to be_strong
			end
		end
		context "with a health of 100 or less" do |variable|
			before do |variable|
				@player = Player.new("larry", 100)
			end

			it "is wimpy" do |variable|
				expect(@player).not_to be_strong
			end
		end
		context "in a collection of players" do |variable|
			before do |variable|
				@player1 = Player.new("moe", 100)
				@player2 = Player.new("larry", 200)
				@player3 = Player.new("curly", 300)

				@players = [@player1, @player2, @player3]
			end
			it "is sorted by decreasing score" do
				puts "#{@players}"
				expect(@players.sort).to eq([@player3, @player2, @player1])
			end
		end
		it "computes points as the sum of all treasure points" do
			expect(@player.points).to eq (0)

			@player.found_treasure(Treasure.new(:hammer, 50))

			expect(@player.points).to eq (50)

			@player.found_treasure(Treasure.new(:crowbar, 400))

			expect(@player.points).to eq (450)

			@player.found_treasure(Treasure.new(:hammer, 50))

			expect(@player.points).to eq (500)
		end
		it "yields each found treasure and its total points" do
		  @player.found_treasure(Treasure.new(:skillet, 100))
		  @player.found_treasure(Treasure.new(:skillet, 100))
		  @player.found_treasure(Treasure.new(:hammer, 50))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  @player.found_treasure(Treasure.new(:bottle, 5))
		  yielded = []
		  @player.each_found_treasure do |treasure|
		    yielded << treasure
		  end
			expect(yielded

			).to eq ([
		    Treasure.new(:skillet, 200),
		    Treasure.new(:hammer, 50),
		    Treasure.new(:bottle, 25)
			])
		end
		it "can be created from a CSV string" do
			player = Player.from_csv("larry,150")
			expect(player.name).to eq ("Larry")
			expect(player.health).to eq (150)
		end
	end
end
