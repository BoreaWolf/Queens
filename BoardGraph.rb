# Graph of Boards used by the DFS algorithm

require_relative "BoardNode.rb"

class BoardGraph

	# Constructor
	def initialize( board_dimension )
		# I create a new BoardGraph setting the root of the graph with an empty
		# board with no action and father
		@root = BoardNode.new( board_dimension )
		# Current node
		@node = @root
	end

	# IDK
	def find_next_actions
		@node.next_state
	end

	def delete_last_action
		@node.delete_last_action
		@node = @node.get_father
	end

	def next_state( action )
		# Creating the new state knowing the action, that represents the number 
		# where the first not placed Queen have to go
		return @node = BoardNode.new( @node.get_board_dimension, @node, action )
	end

	# Useful Getters and Setters
	def get_current_node
		@node
	end

	# Checking if I have found the solution or not
	def solution?
		if DEBUG
			puts "S? -> #{@node.get_state.get_state} = #{@node.final_state?}"
		end
		return @node.final_state? == 0 ? TRUE : FALSE
	end

	def get_solution
		@node.get_state
	end

	def plot_graph
		result = "\n*** BoardGraph plot ***\n"
		result += @node.plot
		result += "\n***********************\n\n"
		return result
	end

	def plot_solution
		@node.plot_state
	end

	def plot_prettier_solution
		@node.plot_prettier_solution
	end
end
