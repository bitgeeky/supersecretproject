class Rover
    def initialize (x_coordinate, y_coordinate, direction)
	@current_x_coordinate = x_coordinate.to_i
	@current_y_coordinate = y_coordinate.to_i
	@current_direction = direction
    end

    def move_rover(instruction)
	if instruction == 'L'
	    if @current_direction == 'N'
		@current_direction = 'W'
	    elsif @current_direction == 'E'
		@current_direction = 'N'
	    elsif @current_direction == 'S'
		@current_direction = 'E'
	    elsif @current_direction == 'W'
		@current_direction = 'S'
	    end
	elsif instruction == 'R'
	    if @current_direction == 'N'
		@current_direction = 'E'
	    elsif @current_direction == 'E'
		@current_direction = 'S'
	    elsif @current_direction == 'S'
		@current_direction = 'W'
	    elsif @current_direction == 'W'
		@current_direction = 'N'
	    end
	elsif instruction == 'M'
	    if @current_direction == 'N'
		@current_y_coordinate += 1
	    elsif @current_direction == 'E'
		@current_x_coordinate += 1
	    elsif @current_direction == 'S'
		@current_y_coordinate -= 1
	    elsif @current_direction == 'W'
		@current_x_coordinate -= 1
	    end
	end
    end
    def get_current_position
	 return @current_x_coordinate, @current_y_coordinate, @current_direction
    end
end

grid_size = gets.chomp

while true do
    initial_position = gets
    x, y, z = initial_position.split
    rover = Rover.new(x, y, z)
    instructions = gets.chomp
    instructions.split("").each do |inst|
	rover.move_rover(inst)
    end
    print (rover.get_current_position).join(" "), "\n"
end