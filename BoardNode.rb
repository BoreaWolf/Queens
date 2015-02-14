# Class representing one node of the graph

require_relative "Board.rb"

class BoardNode

	# Constructor
	def initialize( board_dimension, father = nil, action = nil )
		# puts "New-BN -> dim: #{board_dimension}, f: #{father}, a: #{action}"
		# Current board state
		@state = Board.new( board_dimension )
		unless action.nil?
			@state.assign( father.get_state.get_state )
			self.modify_state( action )
		end
		# Father of the current node, used to backtrack the graph
		@father = father
		# Action done to get at this node, used to get back in the graph
		# Apparently not needed, it has the same purpose as the father node
		# @backward_action = action
		# For this type of problem seems that the action cost is not necessary,
		# since every action costs one.
		# Saving all the possible actions that i could do in this state
		@unexplored_actions = Array.new(0)

		# Used to keep track of sons and siblings
		@sons = Array.new(0)
		@siblings = Array.new(0)
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

	# Stuff for in-graph movements
	def add_son( son )
		@sons += son
	end

	def add_sibling( sibling )
		@siblings += sibling
	end

	def get_sons
		@sons
	end
	
	def get_siblings
		@siblings
	end

	def get_board_dimension
		@state.size
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

	def set_state( state )
		@state.assign( state )
	end

	def final_state?
		@state.final_state?
	end

	def plot
		result = "BN-start\n"
		result += @state.plot 
		result += "\tUn-actions: #{@unexplored_actions}"
		result += "\tFather: #{@father} -> "
		result += @father.nil? ? "nil" : ( "\n" + @father.plot )
		result += "\nBN-end"
		return result
	end
end	
