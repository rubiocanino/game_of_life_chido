class NewRules
  # Die when u have 1 neighb
  # Die when u have 4,5,6.7 neighb
  # Live when u have 2,3 neighb
  require 'colorize'

  def initialize; end

  def checkFriends(checkBoard, borders, squares)
    $checkBoard = checkBoard
    newBoard = []
    size = $checkBoard.size.to_i
    $size = Math.sqrt(size)
    $checkBoard.each_with_index do |cell, index|
      copyBoard = Marshal.load(Marshal.dump(checkBoard))
      case cell.kind
      when 'normal'
        newCell = checkNormalFriends(copyBoard, index)
      when 'border'
        newCell = checkBorderFriends(copyBoard, index, borders)
      when 'square'
        newCell = checkSquareFriends(copyBoard, index, squares)
      end
      newBoard << newCell
    end
    newBoard
  end

  def checkNormalFriends(_board, index)
    copy = Marshal.load(Marshal.dump($checkBoard))
    matches = 0
    pos1 = index - $size - 1
    pos2 = pos1 + 1
    pos3 = pos2 + 1
    pos4 = index - 1
    pos5 = index + 1
    pos6 = index + $size - 1
    pos7 = pos6 + 1
    pos8 = pos7 + 1
    matches += 1 if  $checkBoard[pos1].is_alive?
    matches += 1 if  $checkBoard[pos2].is_alive?
    matches += 1 if  $checkBoard[pos3].is_alive?
    matches += 1 if  $checkBoard[pos4].is_alive?
    matches += 1 if  $checkBoard[pos5].is_alive?
    matches += 1 if  $checkBoard[pos6].is_alive?
    matches += 1 if  $checkBoard[pos7].is_alive?
    matches += 1 if  $checkBoard[pos8].is_alive?
    case matches
    when 0, 1
      copy[index].die
    when 2
      copy[index].live if copy[index].is_alive?
    when 3
      copy[index].live unless copy[index].is_alive?
    when 4, 5, 6
      copy[index].die
    end
    copy[index]
  end

  def checkBorderFriends(_board, index, borders)
    copy = Marshal.load(Marshal.dump($checkBoard))
    matches = 0
    # Top side
    if borders[0].include?(index)
      matches = 0
      pos1 = index - 1
      pos2 = index + 1
      pos3 = pos1 + $size.to_i
      pos4 = pos2 + $size.to_i
      pos5 = index + $size.to_i
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
      matches += 1 if $checkBoard[pos4].is_alive?
      matches += 1 if $checkBoard[pos5].is_alive?
    elsif borders[1].include?(index)
      # Rigth side
      matches = 0
      pos1 = $size - 1
      pos2 = pos1 - 1
      pos3 = pos2 + $size
      pos4 = pos3 + $size
      pos5 = pos4 + 1
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
      matches += 1 if $checkBoard[pos4].is_alive?
      matches += 1 if $checkBoard[pos5].is_alive?
    elsif borders[2].include?(index)
      # Bottom side
      matches = 0
      pos1 = index + 1
      pos2 = pos1 - $size.to_i
      pos3 = pos2 - 1.to_i
      pos4 = pos3 - 1.to_i
      pos5 = pos4 + $size.to_i
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
      matches += 1 if $checkBoard[pos4].is_alive?
      matches += 1 if $checkBoard[pos5].is_alive?
    else
      # Left side
      matches = 0
      pos1 = index - $size
      pos2 = pos1 + 1
      pos3 = pos2 + $size
      pos4 = pos3 + $size
      pos5 = pos4 - 1
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
      matches += 1 if $checkBoard[pos4].is_alive?
      matches += 1 if $checkBoard[pos5].is_alive?
    end
    case matches
    when 0, 1
      copy[index].die
    when 2
      copy[index].live if copy[index].is_alive?
    when 3
      copy[index].live unless copy[index].is_alive?
    when 4, 5, 6
      copy[index].die
    end
    copy[index]
  end

  def checkSquareFriends(_board, index, squares)
    copy = Marshal.load(Marshal.dump($table.board))
    matches = 0
    squares = squares.sort!
    # First square
    if squares[0] == index
      pos1 = 1
      pos2 = pos1 + $size.to_i
      pos3 =  $size.to_i
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
    elsif squares[1] == index
      pos1 = index - 1.to_i
      pos2 = pos1 + $size.to_i
      pos3 =  pos2 + 1.to_i
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
    elsif squares[2] == index
      auxSize = $size * ($size - 1).to_i
      pos1 = auxSize - $size
      pos2 = pos1 + 1
      pos3 =  auxSize + 1
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
    elsif squares[3] == index
      auxSize = ($size * $size) - 1
      pos1 = auxSize - 1
      pos2 = pos1 - $size
      pos3 =  auxSize - $size
      matches += 1 if $checkBoard[pos1].is_alive?
      matches += 1 if $checkBoard[pos2].is_alive?
      matches += 1 if $checkBoard[pos3].is_alive?
    end
    case matches
    when 0, 1
      copy[index].die
    when 2
      copy[index].live if copy[index].is_alive?
    when 3
      copy[index].live unless copy[index].is_alive?
    end
    copy[index]
  end
end
