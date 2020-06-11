require_relative 'Square'
require_relative 'Field'

field = Field.new

p field.knight_moves([0, 1], [7, 5])
