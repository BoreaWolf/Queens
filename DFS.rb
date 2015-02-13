# DFS-Online algorithm applied to the N Queens problem.
# Based on the Board class.

require_relative "BoardGraph.rb"

class DFS

	# Constructor
	def initialize( board )
		# Creating the BoardGraph needed for this algorithm to work
		@graph = BoardGraph.new( board )
	end

	# Finding the solution with a Depth-First Search Online algorithm
	def DFS_solution( state )
		result
		unexplored
		unbacktracked

		# Checking if a got the final solution
		if state.final_state? == 0
			return state
		end

		DFS_solution( new_state )
	end
end
