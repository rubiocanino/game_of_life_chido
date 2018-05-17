require_relative 'cell'
require 'colorize'

class Board
  attr_accessor :board, :size, :squares, :borders
  attr_reader :board

  def initialize
    size = 0
    loop do
      print 'Size of the board ? nxn: '
      size = gets.chomp.to_i
      break if size > 0
    end
    @size = size
    @board = createBoard
    @squares = squarePos(size)
    @borders = borderPos(size)
    checkKindCell
  end

  def createBoard
    j = 1
    board = []
    loop do
      board << Cell.new(j - 1)
      break if j == @size * @size
      j += 1
    end

    puts 'Your board have been created!'.colorize(:green)
    puts "\n"
    display(board)
    board
  end

  def checkKindCell
    @board.each_with_index do |cell, index|
      kind = 'normal' unless @squares.include?(index) && @borders.include?(index)
      kind = 'square' if @squares.include?(index)
      kind = 'border' if @borders[0].include?(index)
      kind = 'border' if @borders[1].include?(index)
      kind = 'border' if @borders[2].include?(index)
      kind = 'border' if @borders[3].include?(index)
      cell.kind = kind
    end
  end

  def display(board = @board)
    i = 1
    cut = []
    loop do
      cut << @size * i
      i += 1
      break if i >= @size * @size
    end
    puts "\n"
    board.each_with_index do |cell, index|
      print cell.state.colorize(:red) if cell.is_alive?
      print cell.state unless cell.is_alive?
      puts "\n" if cut.include?(index + 1)
    end
    puts "\n"
  end

  def randomCells
    cells = 0
    puts "\n"
    puts '-- Random alive cells -- '.colorize(:blue)
    loop do
      print 'How many alive you want?: '
      cells = gets.chomp.to_i
      if (cells <= 0) || (cells > @size * @size)
        print 'Sorry try again. '.colorize(:red)
        gets.chomp
        puts "\n"
        system('clear')
      end
      break if (cells > 0) && (cells < @size * @size)
    end

    i = 0
    loop do
      numberCell = rand * @board.length
      unless board[numberCell].is_alive?
        board[numberCell].live
        i += 1
      end
      break if i + 1 > cells
    end
    self
  end

  def manualCells
    check = 't'
    puts "\n"
    puts '-- Manual alive cells --'.colorize(:blue)
    loop do
      print 'Index of the cell: '
      index = gets.chomp.to_i
      if @board[index].is_alive?
        puts "It's already alive!".colorize(:red)
      else
        @board[index].live unless @board[index].is_alive?
        puts "It's alive!".colorize(:green) if @board[index].is_alive?
      end
      display
      print   'Another cell? true/false: '
      check = gets.chomp
      break if check == 'false'
    end
    self
  end

  def borderPos(size)
    positions = []
    top = []
    bottom = []
    left = []
    rigth = []
    # Top
    (1...size - 1).each { |pos| top << pos }
    # Bottom
    (((size - 1) * size) + 1...((size * size) - 1)).each { |pos| bottom << pos }
    # Left
    index = 0
    i = 1
    loop do
      index += size
      left << index
      i += 1
      break if i > size - 2
    end
    # Rigth
    index = size - 1
    i = 1
    loop do
      index += size
      rigth << index
      i += 1
      break if i > size - 2
    end
    positions << top
    positions << rigth
    positions << bottom
    positions << left
    positions
  end

  def squarePos(size)
    squares = []
    squares << 0
    squares << size - 1
    squares << (size * size) - 1
    squares << (size * (size - 1))
    squares
  end
end
