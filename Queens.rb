#!/usr/bin/env ruby
# N Queens problem solved with the Hill Climbing Algorithm

require_relative "Board.rb"
DEBUG = FALSE

number_of_queens = ( ARGV[ 0 ] || 8 ).to_i
puts "Hello World bitches, we are the #{number_of_queens} Queens."

board = Board.new( number_of_queens )
board.random_start
if DEBUG
	puts "Start #{board.plot}"
end

# Starting with the Hill Climbing algorithm, knowing that we want to stop
# the algorithm after max_steps steps, proportional to the board dimension.
max_steps = number_of_queens * 3 / 2
steps = 0
full_steps = 0
steps_restarts = 0
dead_restarts = 0
start_time = Time.now

until board.board_conflict == 0

	if DEBUG
		puts "Trying #{steps}"
	end
	# Creating new states modifying the current board, trying to minimizing the
	# number of conflicts
	modified = FALSE
	dist = 1
	while dist <= number_of_queens
		full_steps += 1

		if DEBUG
			puts "Neighborhood search distance #{dist}"
		end
		# Searching the best choice from this state
		best_choice = board.best_neighbor dist
		best_choice = best_choice.nil? ? nil : best_choice.get_state
		if board.assign( best_choice )
			if DEBUG
				puts "Found a new best state #{board.plot} with #{board.final_state?} conflicts"
			end
			modified = TRUE
			break
		end
		dist += 1
	end
	
	steps += 1

	# If i reach the MAX_STEPS limit i restart the board with a new configuration
	if steps == max_steps || !modified
		board.random_start
		if DEBUG
			puts "Restarted after #{steps} steps"
			puts "*** Starting a new board: #{board.plot} with #{board.final_state?} conflicts ***"
		end
		steps = 0
		!modified ? dead_restarts += 1 : steps_restarts += 1
	end
end
end_time = Time.now

puts "Solution found: #{board.plot}"
puts "Steps: #{full_steps}"
puts "Random restarts dued to:\n\tSteps: #{steps_restarts}\n\tDead ends: #{dead_restarts}"
puts "Time: #{ end_time - start_time} seconds"
#board.pretty_printer
board.prettier_printer
