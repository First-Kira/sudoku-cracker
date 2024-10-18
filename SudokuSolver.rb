class SudokuSolver
  def initialize(board)
    @board = board
  end

  def solve
    empty_cell = find_empty_cell
    return true unless empty_cell

    row, col = empty_cell

    (1..9).each do |num|
      if is_valid?(num, row, col)
        @board[row][col] = num

        return true if solve

        @board[row][col] = 0 # Backtrack
      end
    end

    false
  end

  def find_empty_cell
    @board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        return [i, j] if cell == 0
      end
    end
    nil
  end

  def is_valid?(num, row, col)
    # Check row
    return false if @board[row].include?(num)

    # Check column
    return false if @board.transpose[col].include?(num)

    # Check 3x3 subgrid
    start_row = (row / 3) * 3
    start_col = (col / 3) * 3

    (0..2).each do |i|
      (0..2).each do |j|
        return false if @board[start_row + i][start_col + j] == num
      end
    end

    true
  end

  def print_board
    @board.each do |row|
      puts row.join(" ")
    end
  end
end

# Example board (0 represents empty cells)
board = [
  [5, 3, 0, 0, 7, 0, 0, 0, 0],
  [6, 0, 0, 1, 9, 5, 0, 0, 0],
  [0, 9, 8, 0, 0, 0, 0, 6, 0],
  [8, 0, 0, 0, 6, 0, 0, 0, 3],
  [4, 0, 0, 8, 0, 3, 0, 0, 1],
  [7, 0, 0, 0, 2, 0, 0, 0, 6],
  [0, 6, 0, 0, 0, 0, 2, 8, 0],
  [0, 0, 0, 4, 1, 9, 0, 0, 5],
  [0, 0, 0, 0, 8, 0, 0, 7, 9]
]

solver = SudokuSolver.new(board)

if solver.solve
  puts "Sudoku solved successfully!"
  solver.print_board
else
  puts "No solution exists."
end
