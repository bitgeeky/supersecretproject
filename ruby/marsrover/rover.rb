class Rover
    def initialize (x_coordinate, y_coordinate, direction, grid_size)
	@max_x, @max_y = grid_size.split
	@max_x, @max_y = @max_x.to_i, @max_y.to_i
	@current_x_coordinate = x_coordinate.to_i
	@current_y_coordinate = y_coordinate.to_i
	@direction_vector = ['N', 'E', 'S', 'W']
	@movement_vector = [{'x'=>0,'y'=>1}, {'x'=>1, 'y'=>0}, {'x'=>0, 'y'=>-1},\
	    {'x'=>-1, 'y'=>0}]
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
	    tmp_x = @current_x_coordinate + @movement_vector[@current_direction_index]['x']
	    tmp_y = @current_y_coordinate + @movement_vector[@current_direction_index]['y']
	    if tmp_x < 0 || tmp_y < 0 || tmp_x > @max_x || tmp_y > @max_y
		return false
	    end
	    @current_x_coordinate += @movement_vector[@current_direction_index]['x']
	    @current_y_coordinate += @movement_vector[@current_direction_index]['y']
	end
	return true
    end
    def get_current_position
	 return @current_x_coordinate, @current_y_coordinate,\
	     @direction_vector[@current_direction_index]
    end
end

grid_size = gets.chomp

while true do
    initial_position = gets
    x, y, z = initial_position.split
    rover = Rover.new(x, y, z, grid_size)
    instructions = gets.chomp
    instructions.split("").each do |inst|
	unless rover.move_rover(inst)
	    puts "Invalid Move"
	end
    end
    print (rover.get_current_position).join(" "), "\n"
end