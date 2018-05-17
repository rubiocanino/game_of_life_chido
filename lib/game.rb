require_relative 'board'
require_relative 'new_Rules'
require 'colorize'
class Game

   def start
    $table = Board.new
    check = false
    puts '1) Random alive Cells'.colorize(:blue)
    puts '2) Choose alive Cells'.colorize(:blue)
    puts '3) Exit'.colorize(:blue)
    puts "\n"
    print 'Option:'
    answer = gets.chomp.to_i
    case answer
    when 1
      $table = $table.randomCells
      gameFlow
    when 2
      $table = $table.manualCells
      gameFlow
    when 3
      return true
    else
      print "That option it's not include | ENTER to continue ".colorize(:red)
      gets.chomp
      system('clear')
    end
    true
  end

  def gameFlow
    $rules = NewRules.new
    i = 0
    check = true
    loop do
      system('clear')
      $table.display($table.board)
      lastBoard = $table.board
      newBoard = $rules.checkFriends($table.board, $table.borders, $table.squares)
      $table.board = newBoard if newBoard != $table.board
      i += 1
      if i % 25 == 0
        print 'Do you want to keep going? true/false '
        check = gets.chomp
        puts "\n"
      end
      break if check == 'false'
    end
    print "All the cell are gonna stay like this, the game it's done | ENTER to continue".colorize(:red)
    gets.chomp
    true
  end
end
