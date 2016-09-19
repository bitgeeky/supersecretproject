class DiceSet
    attr_accessor :values
    def roll(dice_count)
	@values = []
	dice_count.times{ @values << 1 + rand(6)}
    end
    def get_score
	total_score = 0
	number_counts = Hash.new(0)
	# store counts of each number
	@values.each do |num_value|
	    number_counts[num_value] += 1
	end
	# check for triplets
	number_counts.each do |num, count|
	    # handle cases for triplets of 1
	    # 1,1,1
	    if num == 1 && count >=3 then
		total_score += 1000
		count -= 3
		number_counts[1] -= 3
	    end
	    # other triplets
	    if num !=1 && count >= 3 then
		total_score += num * 100
		count -= 3
		number_counts[num] -= 3
	    end
	    if num == 1 && count <=2 then
		total_score += 100 * count
		number_counts[1] -= count
	    end
	    if num == 5 && count <=2 then
		total_score += 50 * count
		number_counts[5] -= count
	    end
	end
	return total_score, number_counts
    end
end

dice_set = DiceSet.new

player = { }

turn_number = 0
print "Enter number of players: "
number_of_players = gets.chomp
number_of_players = number_of_players.to_i

number_of_players.times do |i|
    player[i+1] = {"has_started"=>false, "score"=>0}
end

is_final_round = false
winning_player_id = 0
player_num = 1

while true
    print "Total scores in this round: ", player
    if is_final_round && (player_num > number_of_players) then
	break
    end
    turn_number += 1
    if is_final_round
	print "Final round\n--------------\n"
    else
	print "Turn ", turn_number, ":\n--------\n"
    end
    player_num = 1
    score_for_player = 0
    num_dices = 5
    while (player_num <= number_of_players) do
	if player_num == winning_player_id then
	    print "Skip move for winning player\n"
	    player_num += 1
	    num_dices = 5
	    score_for_player = 0
	    next
	end
	dice_set.roll(num_dices)
	print "Player ", player_num, " rolls: ", dice_set.values, "\n"
	score_in_roll, remaining_counts = dice_set.get_score
	if score_in_roll.to_i > 0
	    score_for_player += score_in_roll
	else
	    score_for_player = 0
	end
	print "Score in this roll: ", score_in_roll, "\n"
	print "Score in this turn: ", score_for_player, "\n"
	non_scoring_dices = 0
	remaining_counts.each do |key, non_scoring_count|
	    non_scoring_dices += non_scoring_count
	end
	num_dices = non_scoring_dices
	if score_in_roll.to_i > 0 then
	    if non_scoring_dices.to_i > 0 then
		print "Do you want to roll the non-scoring ", non_scoring_dices, " dice? (y/n): "
	    else
		print "Do you want to roll all the scoring dice again? (y/n): "
	    end
	    is_roll_again = gets.chomp
	    next if is_roll_again == "y"
	    if is_roll_again == "n" then
		if player[player_num]["has_started"] then
		    player[player_num]["score"] += score_for_player
		elsif score_for_player.to_i >= 300 then
		    player[player_num]["has_started"] = true
		    player[player_num]["score"] += score_for_player
		end
		if player[player_num]["score"] >= 3000 && (!is_final_round) then
		    is_final_round = true
		    winning_player_id = player_num
		    print "\n"
		    break
		end
	    end
	end
	print "\n"
	player_num += 1
	num_dices = 5
	score_for_player = 0
    end
end

highest_score = 0

player.each do |key, details|
    if details["score"] > highest_score
	highest_score = details["score"]
	winning_player_id = key
    end
end

print "Winner is: ", winning_player_id, " with a score of: ", highest_score, "\n"
