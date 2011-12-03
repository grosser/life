class Life
  def initialize(life)
    @board = new_board(5)
    life.each do |row, col|
      @board[row][col] = '#'
    end
  end

  def board
    @board.map{|line| line.join('') }.join("\n")
  end

  def new_board(dimension)
    Array.new(dimension).map{ Array.new(dimension).fill(' ') }
  end

  def iterate
    _board = new_board(@board.size + 2)
    _board.each_with_index do |row,i|
      row.each_with_index do |col,j|
        _board[i][j] = will_be_live(i-1,j-1) ? '#' : ' '
      end
    end

    if _board.first.uniq == [' '] and _board.last.uniq == [' ']
      if _board.map{|row| [row.first, row.last] }.flatten.uniq == [' ']
        _board.shift
        _board.pop
        _board = _board.map{|row| row[1..-2] }
      end
    end

    @board = _board
  end

  def will_be_live(row, col)
    neighbors_count = [
      (@board[row-1][col-1] rescue nil),
      (@board[row-1][col] rescue nil),
      (@board[row-1][col+1] rescue nil),
      (@board[row][col-1] rescue nil),
      (@board[row][col+1] rescue nil),
      (@board[row+1][col-1] rescue nil),
      (@board[row+1][col] rescue nil),
      (@board[row+1][col+1] rescue nil),
    ].select{|x|x=='#'}.size

    if (@board[row][col] rescue nil) == '#'
      [2,3].include? neighbors_count
    else
      [3].include? neighbors_count
    end
  end
end
