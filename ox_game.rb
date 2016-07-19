#!/bin/env ruby

# This program is a naughts and crosses game.
def draw_board(board_matrix)
	puts "current game:"
	count=1
	board_matrix.each { |pos|
		print pos
		if count % 3 == 0
			puts ""
		end
		count += 1
	}
end

def get_user_symbol()
	puts "Do you want to play O and X?"
	puts "y = yes"
	puts "n = no"
	user_input = gets.chomp
	if user_input == "y"
		p1_symbol=false
		while !p1_symbol
			puts "Do you want to be O or X?"
			user_input = gets.chomp.downcase
			if user_input == "o"
				user1_symbol = "o"
			elsif user_input == "x"
				user1_symbol = "x"
			else
				puts "That doesn't seem to be a valid symbol."
				break	
			end
			p1_symbol=true
			# user 2 is what ever user1 isnt
			user2_symbol = user1_symbol == "x" ? "o" : "x"
		end

		p2=false
		while !p2
			puts "Do you have another player?"
			puts "y = yes"
			puts "n = no (I'll play with you <computers always win!!>)"
			user_input=gets.chomp.downcase
			if user_input == "y"
				player2 = "h"
				puts "Player 2 is #{user2_symbol}'s"
			elsif user_input == "n"
				player2 = "c"
				puts "Ok, I'll be #{user2_symbol}'s"
			else
				puts "This is not a yes or no. Please don't be like that!"
				break
			end
			p2=true
		end
			

		puts "Great lets get started!"
		draw_postion
		return user1_symbol, user2_symbol, player2
	else
		puts "Exiting."
		exit 1
	end
end

def draw_postion
	puts "Here is the board layout."
	puts "1 2 3"
	puts "4 5 6"
	puts "7 8 9"
end

def get_user_pos()
	puts "where would you like to go?"
	user_input = gets.chomp
	return user_input
end

def extract_value(values, current_board)
	retval = Array.new
	values.each { |pos| 
		retval << current_board[pos]
	}
	return retval.join
end

def string_checker(pass_string)
	if pass_string == "x"*3 ||
	    pass_string == "o"*3
    	retval=true
    else
    	retval=false
    end
    return retval
end

def check_winner(current_board)
	have_winner = false

	if string_checker(extract_value([0,1,2], current_board))|| 
	   string_checker(extract_value([3,4,5], current_board))||
	   string_checker(extract_value([6,7,8], current_board))||
	   string_checker(extract_value([0,3,6], current_board))||
	   string_checker(extract_value([1,4,7], current_board))||
	   string_checker(extract_value([2,5,8], current_board))||
	   string_checker(extract_value([0,4,8], current_board))||
	   string_checker(extract_value([2,4,6], current_board))

	   have_winner = true
	   return have_winner
	end

	if !(current_board.join).include?("-")
		puts "##############################"
		puts "##        It a draw!        ##"
		puts "##############################"
		exit 0
	end
end

def valid_move?(position,current_board)
	if current_board[position] == "-"
		retval = true
	else
		retval = false
	end
	return retval
end

def computer_move(current_board)
	valid = false
	until valid
		move = rand(1..9)
		if current_board[move] == "-"
			valid = true
		end
	end
	return move
end

def play_game()
	# board layout.
	board = ["-","-","-","-","-","-","-","-","-"]
	winner = false
	user1_symbol,user2_symbol,player2_type = get_user_symbol
	
	turn = 1
	while !winner
		turn_valid = false
		if check_winner(board)
			puts "######################################"
			puts "##  It looks like we have a winner! ##"
			puts "######################################"
			draw_board(board)
			exit 0
		else 
			if turn % 2 > 0
				#player 1 turn
				puts "Player 1 make a move."
				until turn_valid
					pos = get_user_pos.to_i - 1
					if valid_move?(pos,board)
						board[pos] = user1_symbol
						turn_valid=true
					else
						puts "Not a valid move, Please turn to not cheat!"
					end
				end
			else
				#player 2 turn
				puts "Player 2 make a move."
				if player2_type == "h"
					until turn_valid
						pos = get_user_pos.to_i - 1
						if valid_move?(pos,board)
							board[pos] = user2_symbol
							turn_valid=true
						else
							puts "Not a valid move, Please turn to not cheat!"
						end
					end
				else
					#player 2 turn as computer!
					board[computer_move(board)] = user2_symbol
				end
			end
			draw_board(board)
			turn += 1
		end
	end
end

play_game