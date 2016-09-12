class Rover
    def initialize (x_coordinate, y_coordinate, direction)
	@current_x_coordinate = x_coordinate.to_i
	@current_y_coordinate = y_coordinate.to_i
	@direction_vector = ['N', 'E', 'S', 'W']
	@movement_vector = [{'x'=>0,'y'=>1}, {'x'=>1, 'y'=>0}, {'x'=>0, 'y'=>-1}, {'x'=>-1, 'y'=>0}]
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
	    @current_x_coordinate += @movement_vector[@current_direction_index]['x']
	    @current_y_coordinate += @movement_vector[@current_direction_index]['y']
	end
    end
    def get_current_position
	 return @current_x_coordinate, @current_y_coordinate, @direction_vector[@current_direction_index]
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