# DFS-Online algorithm applied to the N Queens problem.
# Based on the Board class.

require_relative "BoardGraph.rb"

class DFS

	# Constructor
	def initialize( board_dimension )
		# Creating the BoardGraph needed for this algorithm to work
		@graph = BoardGraph.new( board_dimension )
	end

	# Finding the solution with a Depth-First Search Online algorithm
	def DFS_solution

		puts "INSIDE!"
		# Checking if I got the final solution
		if @graph.solution?
			return @graph.get_solution
		end

		# If not i'll find which are the possible next actions from this state
		# and iterates on them.
		@graph.find_next_actions
		puts "Found next actions: #{@graph.get_current_node.get_unexplored_actions}"
		@graph.get_current_node.get_unexplored_actions.each do |i|
			# I have to create a new node starting from the current one and 
			# knowing the action we have chosen
			puts "Trying with the action #{i}"
			@graph.next_state( i )
			self.DFS_solution
		end

		# If I get here means that with this configuration I will not get to a
		# solution, so I have to delete what I did in this step.
		# I'll delete the last positioned Queen, replacing it with a nil.
		puts "BACKWARD!"
		return FALSE

	end

	def plot_board
		@graph.plot
	end
end
