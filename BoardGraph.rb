# Graph of Boards used by the DFS algorithm

require_relative "Board.rb"

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
		# Creting the new state knowing the action, that represents the number 
		# where the first not placed Queen have to go
		next_node = @node.clone
		next_node.set_father( @node )
		next_node.modify_state( action )
		next_node.clear_unexplored
		@node = next_node
		return next_node
	end

	# Useful Getters and Setters
	def get_current_node
		@node
	end

	# Checking if I have found the solution or not
	def solution?
		#TODO I think that i could only return !@node.final_state?
		puts "BoardGraph solution?: #{@node.get_state.get_state} -> #{@node.final_state?}"
		return @node.final_state? == 0 ? TRUE : FALSE
	end

	def get_solution
		@node.get_state
	end

	def plot
		@node.plot
	end
end

# Class representing one node of the graph
class BoardNode

	# Constructor
	def initialize( board_dimension, father = nil )
		# Current board state
		@state = Board.new( board_dimension )
		# Father of the current node, used to backtrack the graph
		@father = father
		# Action done to get at this node, used to get back in the graph
		# Apparently not needed, it has the same purpose as the father node
		# @backward_action = action
		# For this type of problem seems that the action cost is not necessary,
		# since every action costs one.
		# Saving all the possible actions that i could do in this state
		@unexplored_actions = Array.new(0)
	end

	# Creating the next state given a chosen action
	def next_state
		# I have an array of possible positions where i could put Queens without
		# creating conflicts
		@unexplored_actions = @state.find_actions
	end

	def delete_last_action
		@state.remove_last_queen
	end

	# Useful Getters and Setters
	def get_unexplored_actions
		@unexplored_actions
	end

	def set_unexplored_actions( actions )
		@unexplored_actions = actions
	end
	
	def clear_unexplored
		@unexplored_actions = Array.new(0)
	end

	def set_father( father )
		@father = father
	end

	def modify_state( action )
		@state.add_queen( action )
	end

	def get_state
		@state
	end

	def final_state?
		@state.final_state?
	end

	def plot
		result = @state.plot 
		result += "\tFather: #{@father}} ->\n"
		result += @father.nil? ? "nil" : @father.plot
		return result
	end
end	
