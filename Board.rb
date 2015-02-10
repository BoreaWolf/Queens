# Chess board
# In this model we will represent the board as a monodimensional array where
# each of its item contains the number of the row where the Queen will be 
# positioned.

class Board

	# Constructor
	def initialize( d )
		@board = Array.new( d, NIL )
		random_start
	end

	# Creating a new random start for the board
	def random_start
		# @board.collect!{ rand( @board.length ) }
		# @board = 1.step( @board.length, 1 ).to_a.shuffle
		@board = Array.new( @board.length ){ |e| e }.shuffle
	end

	# Creating the neighborhood of the current state
	# The parameter distance is the movement that every Queen is supposed to do
	def best_neighbor( distance = 1 )
		current_conflicts = final_state?( @board )
		neighborhood = Array.new(0) 
		@board.each_with_index do | board_i, i |
			[-1, 1].each do
				|sign| 
				neighbor = @board.clone
				(board_i+sign*distance).between?( 0, @board.length-1 ) ? 
					neighbor[i]=board_i+sign*distance : neighbor[i]=nil
				if neighbor.count{ |j| j.nil? } == 0
					# Check only for improvements, staying at the same number 
					# of conflicts will make the job a lot harder and longer.
					neighbor_conflicts = final_state?( neighbor )
					# Checking the difference between the arrays is useless,
					# because if they are the same they will also have the 
					# same amount of conflicts so, given the fact that we are 
					# looking for only improvements, that array will not be 
					# checked anyway.
					# if neighbor != @board && conflicts_neighbor < best[1]
					if neighbor_conflicts < current_conflicts
						neighborhood << neighbor
					end
				end
			end
		end

		# return best[0]
		# I return one random neighbor from the neighborhood
		# I should weight the probabilities or return the best one, but if I 
		# am looking for the best one then i could find it updating one value 
		# and not keeping all the neighborhood.
		return neighborhood[ rand( neighborhood.length ) ]
	end

	# Assigning a new state to the board
	def assign( state )
		if !state.nil? && state != @board
			@board = state
			return TRUE
		else
			return FALSE
		end
	end

	# Checking if the state is correct: every Queen is safe from the others.
	def final_state?( state = @board )
		# Controlling if there are duplicates values in the array, which means
		# two Queens in the same column of the board.
		conflicts = state.count{ |i| state.count( i ) > 1 }
		# I have to check if there are diagonal attacks
		# I could easily check this by comparing the distance of the 
		# elements: if the distance equals the difference of the numbers 
		# then we have an attack
		state.each_with_index do | elem_j, j |
			for k in j+1..state.length-1
				if !( elem_j != state[ k ] + ( k - j ) &&
					  elem_j != state[ k ] - ( k - j ) )
					# return FALSE
					conflicts += 1
				end
			end
		end

		return conflicts
	end

	# Printer
	def plot
		return "#{@board}"
	end

	# Pretty printer
	def pretty_printer
		@board.each{ |i| printf( "%#{i+1}c\n", "Q" ) }
	end

	# Prettier printer
	def prettier_printer
		@board.each{ |i|
			for j in 0..i-1
				printf "-"
			end
			printf "Q"
			for j in i+1..@board.length-1
				printf "-"
			end
			printf "\n"
		}
	end
end
