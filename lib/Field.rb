require_relative 'Square'

class Field
  attr_accessor :field

  def field; @field; end

  def initialize
    @field = Array.new(8) {Array.new(8)}
    self.field_fill # fills the field with 8x8 Square class objects with position data
    self.connect  # makes a tree - assigns all squares where the knight can make a move into neighbours array
  end

  def field_fill
    @field.map!.with_index do |column, i|
      column.map!.with_index do |row, j|
        row = Square.new([i, j])
      end
    end
  end

  def connect
    @field.each_with_index do |column, i|
      column.each_with_index do |row, j|

        row.neighbours << @field[i + 1][j + 2] if (i + 1 < 8) && (j + 2 < 8)
        row.neighbours << @field[i + 1][j - 2] if (i + 1 < 8) && (j - 2 > -1)
        row.neighbours << @field[i - 1][j + 2] if (i - 1 > -1) && (j + 2 < 8)
        row.neighbours << @field[i - 1][j - 2] if (i - 1 > -1) && (j - 2 > -1)
        row.neighbours << @field[i + 2][j + 1] if (i + 2 < 8) && (j + 1 < 8)
        row.neighbours << @field[i + 2][j - 1] if (i + 2 < 8) && (j - 1 > -1)
        row.neighbours << @field[i - 2][j + 1] if (i - 2 > -1) && (j + 1 < 8)
        row.neighbours << @field[i - 2][j - 1] if (i - 2 > -1) && (j - 1 > -1)

      end
    end
  end

  def knight_moves(from, to, queue = [], path = [])
    @field[from.first][from.last].neighbours.each do |node|      
      if node.position != to
        queue << node
      else
        return path.unshift node.position
      end
    end

    from = queue.shift.position
    knight_moves(from, to, queue, path) # level order search

    # if two nodes are neighbours on the field
    if @field[path.first.first][path.first.last].neighbours.any? { |node| node.position == from }
      path.unshift from
    end
    path
  end
end
