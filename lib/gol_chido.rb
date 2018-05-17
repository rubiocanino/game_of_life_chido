require "gol_chido/version"
require_relative 'game'

module GolChido
  class GameOfLife

    def start
      system('clear')
      loop do
        puts '========== M E N U =========='
        puts '   Press enter to start.'.colorize(:blue)
        gets.chomp
        Game.new.start
        puts "\n"
        puts 'Wanna play again? true/false'
        break if gets.chomp.casecmp('false').zero?
      end
      3.times { puts "\n" }
      puts '~~~~~~~~~~~~~~~~ Thanks for playing ~~~~~~~~~~~~~~~~~'.colorize(:green)
      puts '~~~~~~~~~~~~~ Gem created by rubiocanino ~~~~~~~~~~~~~'.colorize(:green)
      puts ''
      sleep(1)
    end
  end

end


