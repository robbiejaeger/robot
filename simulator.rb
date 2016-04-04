class Robot

  attr_reader :bearing

  def initialize
    @possible_directions = [:north, :east, :south, :west]
  end

  def orient(direction)
    if @possible_directions.include?(direction)
      @bearing = direction
    else
      raise ArgumentError
    end
  end

  def turn_right
    current_index = @possible_directions.index(@bearing)
    current_index += 1
    @bearing = @possible_directions[current_index % 4]
  end

  def turn_left
    current_index = @possible_directions.index(@bearing)
    current_index -= 1
    @bearing = @possible_directions[current_index % 4]
  end

  def at(x, y)
    @x = x
    @y = y
  end

  def coordinates
    @coordinates = [@x, @y]
  end

  def advance
    # TODO: Add hash for directions
    @y += 1 if @bearing == :north
    @y -= 1 if @bearing == :south
    @x += 1 if @bearing == :east
    @x -= 1 if @bearing == :west
  end
end

class Simulator

  def initialize
    @hash = {turn_right: "R", advance: "A", turn_left: "L"}
  end

  def instructions(directions)
    directions.chars.map do |letter|
      @hash.key(letter)
    end
  end

  def place(robot, hash)
    robot.at(hash[:x], hash[:y])
    robot.orient(hash[:direction])
  end

  def evaluate(robot, directions)
    instructions_array = instructions(directions)
    instructions_array.each do |instruction|
      robot.send(instruction.to_s)
    end
  end

end
