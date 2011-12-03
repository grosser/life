class Life
  X = 15

  def initialize(life)
    @board = new_board
    life.each do |row, col|
      @board[row][col] = '#'
    end
  end

  def board
    @board.map{|line| line.join('') }.join("\n")
  end

  def new_board
    Array.new(X).map{ Array.new(X).fill(' ') }
  end

  def iterate
    _board = new_board
    @board.each_with_index do |row,i|
      row.each_with_index do |col,j|
        _board[i][j] = will_be_live(i,j) ? '#' : ' '
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

    if @board[row][col] == '#'
      [3].include? neighbors_count
    else
      [2,3].include? neighbors_count
    end
  end
end
