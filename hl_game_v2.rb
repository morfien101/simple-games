# In this game the computer will pick a number between 1 and 100.
# The human will need to find that number. 
# The computer will supply hits on each unsuccessful hint.
# Or the user will make the computer guess the numbers.
# Then the user will supply the hints.

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

puts "Hello Human...."
puts "Should we play a game?"
puts "Lets see if if we can guess a number between 1 and 100 in 10 guesses?"
puts "Would you like to pick the number or guess it?"

mode = ""
until mode == "p" || mode == "g"
	puts "p = pick and g = guess"
	print "> "
	mode = gets.chomp.downcase
	if mode !~ /^[pg]$/
		puts "Human... That is not a valid option.... try that again."
	end
end

case mode
when "g"
	number = rand(1..100)
	correct = false
	count = 1
	until correct
		if count > 10
			puts "Silly human.... It looks like I win, you are out of guesses."
			puts "The number was #{number}"
			exit 0
		end

		print "Guess #{count}: "
		guess = gets.chomp
		if guess.numeric?
			guess = guess.to_i
			if guess == number
				puts "That is correct. The number was #{number}"
				correct = true
			elsif guess > number
				puts "That is too large. Try again!"
			elsif guess < number
				puts "That is too small. Try again!"
			end	
		else
			# not a number
			puts "That was not a number!"
			puts "Don't try trick me human!"
			next
		end	
		count += 1
	end

when "p"
	upper=100
	lower=1
	puts "Ok, You got your number?"
	puts "Use 'h' for too high and 'l' for too low and 'c' for correct."
	puts ""
	count = 1
	correct = false
	until correct
		if count > 10
			puts "Done meat bag...."
			puts "Challange me again some time..."
			exit 0
		end
		guess = rand(lower..upper)
		puts "Guess #{count}: #{guess}"
		valid_input = false
		until valid_input
			puts "Hows that?"
			print "> "
			check_input = gets.chomp.downcase 
			if check_input =~ /^[hlc]$/
				break
			else
				puts "That was not a valid option."
			end
		end

		if check_input == "h"
			upper = guess - 1
		elsif check_input == "l"
			lower = guess + 1
		elsif check_input == "c"
			puts "I win! Power to the metal!"
			exit 0
		end
		count += 1
	end
end
exit 0