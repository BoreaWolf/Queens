#!/usr/bin/env ruby
# N Queens problem solved with the Hill Climbing Algorithm

require_relative "Board.rb"
MAX_STEPS = 20
DEBUG = FALSE

number_of_queens = ( ARGV[ 0 ] || 8 ).to_i
puts "Hello World bitches, we are the #{number_of_queens} Queens."

board = Board.new( number_of_queens )

# Starting with the Hill Climbing algorithm, knowing that we want to stop
# the algorithm after 20-30 steps.
steps = 0
full_steps = 0
steps_restarts = 0
dead_restarts = 0
start_time = Time.now
until board.final_state? == 0

	if DEBUG
		puts "Trying #{steps}"
	end
	# Creating new states modifying the current board, trying to minimizing the
	# number of conflicts
	modified = FALSE
	dist = 1
	while dist <= number_of_queens/2
		full_steps += 1

		if DEBUG
			puts "Neighborhood search distance #{dist}"
		end
		if board.assign( board.best_neighbor dist )
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
	if steps == MAX_STEPS || !modified
		board.random_start
		if DEBUG
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
