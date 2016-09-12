class Rover
    def initialize (x_coordinate, y_coordinate, direction)
	@current_x_coordinate = x_coordinate.to_i
	@current_y_coordinate = y_coordinate.to_i
	@direction_vector = ['N', 'E', 'S', 'W']
	@current_direction_index = @direction_vector.index(direction)
    end

    def move_rover(instruction)
	if instruction == 'L'
	    @current_direction_index -= 1
	    @current_direction_index %= 4
	elsif instruction == 'R'
	    @current_direction_index += 1
	    @current_direction_index %= 4
	elsif instruction == 'M'
	    if @current_direction_index == 0
		@current_y_coordinate += 1
	    elsif @current_direction_index == 1
		@current_x_coordinate += 1
	    elsif @current_direction_index == 2
		@current_y_coordinate -= 1
	    elsif @current_direction_index == 3
		@current_x_coordinate -= 1
	    end
	end
    end
    def get_current_position
	 return @current_x_coordinate, @current_y_coordinate, @current_direction, @direction_vector[@current_direction_index]
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