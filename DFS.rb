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

		# Checking if I got the final solution
		if @graph.solution?
			if DEBUG
				puts "Solution found:\n#{@graph.plot_graph}"
			end
			return 0
		end

		# If not i'll find which are the possible next actions from this state
		# and iterates on them.
		result = -1
		@graph.find_next_actions
		if DEBUG
			puts "Un-A -> #{@graph.get_current_node.get_unexplored_actions}"
		end
		# TODO Make this correct, i am skipping a level in the structures
		@graph.get_current_node.get_unexplored_actions.each do |i|
			# I have to create a new node starting from the current one and 
			# knowing the action we have chosen
			@graph.next_state( i )
			result = self.DFS_solution
			# With break I have to pass over all the calls in the recursive
			# stack, with return it skips all these steps.
			# break if result == 0
			return 0 if result == 0
		end

		# If I get here means that with this configuration I will not get to a
		# solution, so I have to delete what I did in this step.
		# I'll delete the last positioned Queen, replacing it with a nil.
		unless result == 0
			if DEBUG
				puts "BACKWARD!"
			end
			@graph.delete_last_action
			return -1 
		end

	end

	def plot_solution
		@graph.plot_solution
	end

	def plot_graph
		@graph.plot_graph
	end

	def plot_prettier_solution
		@graph.plot_prettier_solution
	end
end
