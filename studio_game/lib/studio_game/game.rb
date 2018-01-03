require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'
module StudioGame
	class Game
		def initialize (title)
			@title = title
			@players = []
		end
		def add_player (a_player)
			@players.push (a_player)
		end
		def load_players(from_file)
			File.readlines(from_file).each do |line|
				add_player(Player.from_csv(line))
			end
		end
		def play(rounds)
			puts "There are #{@players.size} players in #{@title}:"
			@players.each do |player|
				puts player
			end
			treasures = TreasureTrove::TREASURES
			puts "\nThere are #{treasures.size} Treasures to be found:"
			treasures.each do |treasure|
				puts "A #{treasure.name} is worth #{treasure.points} points"
			end
			1.upto(rounds) do |round|
				if block_given?
					break if yield
				end
				puts "\nRound #{round}:"
				@players.each do |player|
					GameTurn.take_turn(player)
					puts player
				end
			end
		end
		def total_points
			@players.reduce(0) { |sum, player| sum + player.points }
		end
		def print_name_and_health(player)
			puts "#{player.name} #{player.health}"
		end
		def high_score_entry(player)
			formatted_name = player.name.ljust(20, '.')
			puts "#{formatted_name} #{player.score}"
		end
		def print_stats
			strong_players, wimpy_players = @players.partition { |player| player.strong?}
			puts "\n#{@title} Statistics:"

			puts "\n#{strong_players.size} Strong Players:"
			strong_players.each do |player|
				print_name_and_health(player)
			end
			puts "\n#{wimpy_players.size} Wimpy Players:"
			wimpy_players.each do |player|
				print_name_and_health(player)
			end
			puts "\n#{@title} High Scores:"
			@players.sort.each do |player|
				puts high_score_entry(player)
			end
			@players.each do |player|
				puts "\n#{player.name}'s point totals:"
				player.each_found_treasure do |treasure|
					puts "#{treasure.points} total #{treasure.name} points"
				end
				puts "#{player.points} grand total points"
			end
			puts "#{total_points} total points from treasures found"
		end
		def save_high_score(to_file="high_score.txt")
			File.open(to_file, "w") do |file|
				file.puts "#{@title} High Score:"
				@players.sort.each do |player|
					puts high_score_entry(player)
				end
			end
		end
		attr_reader :title
	end
end
if __FILE__ == $0
	puts "Successful Test"
end
