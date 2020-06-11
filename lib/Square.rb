class Square
  attr_accessor :neighbours, :position

  def initialize(position = [], *neighbours)
    @position = position
    @neighbours = neighbours
  end

  def neighbours; @neighbours; end
  def position; @position; end
end
