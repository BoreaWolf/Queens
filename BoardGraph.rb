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
	end

	def next_state( action )
		# Creating the new state knowing the action, that represents the number 
		# where the first not placed Queen have to go
	#	next_node = BoardNode.new( @node.get_board_dimension )
	#	#next_node = @node.clone
	#	# Setting the father of this new node the current node
	#	next_node.set_father( @node )
	#	# Setting its board, as a modify of the current node state.
	#	# First I'll set the state to be the same as the current, then I'll
	#	# modify it with the action chosen.
	#	next_node.set_state( @node.get_state )
	#	next_node.modify_state( action )
	#	#@node = next_node
	#	return next_node
		return @node = BoardNode.new( @node.get_board_dimension, @node, action )
	end

	# Useful Getters and Setters
	def get_current_node
		@node
	end

	# Checking if I have found the solution or not
	def solution?
		#TODO I think that i could only return !@node.final_state?
		puts "S? -> #{@node.get_state.get_state} = #{@node.final_state?}"
		return @node.final_state? == 0 ? TRUE : FALSE
	end

	def get_solution
		@node.get_state
	end

	def plot
		result = "\n*** BoardGraph plot ***\n"
		result += @node.plot
		result += "\n***********************\n\n"
		return result
	end

	def plot_graph

	end
end
