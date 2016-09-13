require './rover.rb'

grid_size = gets.chomp

while true do
    initial_position = gets
    x, y, z = initial_position.split
    rover = Rover.new(x, y, z, grid_size)
    instructions = gets.chomp
    instructions.split("").each do |inst|
	unless rover.move(inst)
	    puts "Invalid Move"
	end
    end
    print (rover.get_current_position).join(" "), "\n"
end