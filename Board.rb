# Chess board
# In this model we will represent the board as a monodimensional array where
# each of its item contains the number of the row where the Queen will be 
# positioned.

class Board

	# Constructor
	def initialize( d )
		@board = Array.new( d, NIL )
	end

	# Creating a new random start for the board
	def random_start
		@board = (0...@board.length).to_a.shuffle
	end

	# Assigning a new state to the board
	# TODO Change assign in set_state
	def assign( state )
		if !state.nil? && state != @board
			@board = state
			return TRUE
		else
			return FALSE
		end
	end

	# Getting the current state
	def get_state
		@board
	end

	# Size of the board
	def size
		@board.length
	end

	# Counting the conflicts that a Queen generates
	def queen_conflict( index )
		conflict = @board.count{ |i| i == @board[index] } - 1

		@board.each_with_index do | elem_i, i |
			if i != index && elem_i != nil && 
				( @board[index] - elem_i ).abs == ( i - index ).abs
				conflict += 1
			end
		end

		return conflict
	end

	# Counting the conflicts of all the board, summing the Queens' conflicts
	def board_conflict
		return (0...@board.length).inject(0){ |sum, i| sum + queen_conflict(i) }
	end

	# Checking if a reached the final state using the DFS algorithm
	def final_state?
		# First of all i have to check if the board is complete, if every queen
		# is positioned on the board
		if @board.count{ |i| i.nil? } > 0
			return -1
		end

		# Then i'll return the number of conflicts 
		return board_conflict
	end

	# Assigning a new valid position for the first not yet positioned queen
	def find_actions
		# I am working on a not full Queen board, so i'm going to take the 
		# first not positioned Queen, following the order of the rows, and 
		# finding all the possible valid positions without generating conflicts

		# I will work on a copy of the original board, or it will be modified 
		# also outside
		board_original = @board.clone
		row = @board.find_index( nil )
		# If there is no other possible Queen to place then I return a failure
		unless row.nil?
			# Really bad probably! But whatever.
			# TODO Not sure if it's correct, probably not because adds the 
			# indexes after deleting some elements. To be checked anyway, even 
			# if i changed it.
			positions = (0...@board.length).map{ |i| 
				@board[row] = i
				queen_conflict( row ) }.map.with_index.to_a.keep_if{ |i| i[0]==0 }.map(&:last)
		end

		# Restoring the original board
		@board = board_original.clone

		return positions

	end

	# Setting the first not positioned queen at the given position
	def add_queen( position )
		@board[ @board.find_index( nil ) ] = position 
		puts "Queen-A #{position} -> #{@board}"
	end

	# Deletes the last queen from the board
	def remove_last_queen
		row = ( @board.find_index( nil ) ? @board.find_index( nil ) : @board.length ) - 1
		string = "#{@board}"
		@board[ row ] = nil
		string += " => #{@board}"
		puts "D-Q #{row} -> #{string}"
	end

	# Printer
	def plot
		return "Board: #{@board}"
	end

	# Pretty printer
	def pretty_printer
		@board.each{ |i| printf( "%#{i+1}c\n", "Q" ) }
	end

	# Prettier printer
	def prettier_printer
		puts "#{@board}"
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

	# Creating the neighborhood of the current state based on a Hill-Climbing
	# local search.
	# The parameter distance is the movement that every Queen is supposed to do
	def best_neighbor( distance = 1 )
		current_conflicts = self.board_conflict
		neighborhood = Array.new(0) 
		# Cycling on the array, sorting it by the number of conflicts that 
		# every queen generates.
		(0...@board.length).map{ |i| queen_conflict(i) }.map.with_index.sort.reverse.map(&:last).each do |i|
			[-1, 1].each do	|sign| 
				neighbor = @board.clone
				(@board[i]+sign*distance).between?( 0, @board.length-1 ) ? 
					neighbor[i]=@board[i]+sign*distance : neighbor[i]=nil
				if neighbor.count{ |j| j.nil? } == 0
					# Check only for improvements, staying at the same number 
					# of conflicts will make the job a lot harder and longer.
					neighbor_board = Board.new( @board.length )
					neighbor_board.assign( neighbor )
					neighbor_conflicts = neighbor_board.board_conflict
					
					# Checking the difference between the arrays is useless,
					# because if they are the same they will also have the 
					# same amount of conflicts so, given the fact that we are 
					# looking for only improvements, that array will not be 
					# checked anyway.
					if neighbor_conflicts < current_conflicts
						neighborhood += Array.new( current_conflicts - neighbor_conflicts, neighbor_board )
					end
				end
			end
	end

		# I return one random neighbor from the neighborhood
		# I should weight the probabilities or return the best one, but if I 
		# am looking for the best one then i could find it updating one value 
		# and not keeping all the neighborhood.
		return neighborhood[ rand( neighborhood.length ) ]
	end

end
