require 'pry'

class Matrix
  attr_accessor :rows, :columns, :saddle_points

  def initialize(matrix_string)
    self.rows = render_rows(matrix_string)
    self.columns = render_columns(rows)
    self.saddle_points = find_saddle_points(rows, columns)
  end

  def render_rows(matrix_string)
    row_strings = matrix_string.split("\n")
    row_strings.map { |row| row.split(' ').map! {|n| n.to_i } }
  end

  def render_columns(rows)
    columns = []
    rows.each_with_index do |row, row_index|
      row.each_with_index do |number, index|
        row_index == 0 ? columns[index] = [number] : columns[index] << number
      end
    end
    columns
  end

  def find_saddle_points(rows, columns)
    saddle_points = []
    rows.each_with_index do |row, row_index|
      row_max = row.max
      column_indices_with_highest_value_in_row = []
      row.each_with_index do |number, index|
        column_indices_with_highest_value_in_row << index if number == row_max
      end
      column_indices_with_highest_value_in_row.each do |column_index|
        saddle_points << [row_index, column_index] if row[column_index] == columns[column_index].min
      end
    end
    saddle_points
  end
end
