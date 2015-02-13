# Graph of Boards used by the DFS algorithm

require_relative "Board.rb"

class BoardGraph

	# Constructor
	def initialize( board )
		# I create a new BoardGraph setting the root of the graph with an empty
		# board with no action and father
		@root = BoardNode.new( board )
	end
end

# Class representing one node of the graph
class BoardNode

	# Constructor
	def initialize( board, action = nil, father = nil )
		# Current board state
		@state = board
		# Father of the current node, used to backtrack the graph
		@father = father
		# Action done to get at this node, used to get back in the graph
		@action = action
		# For this type of problem seems that the action cost is not necessary,
		# since every action costs one.
		# Saving all the possible actions that i could do in this state
		@unexplored_actions = Array.new(0)
	end

	# Useful Getters and Setters
	def get_unexplored_actions
		@unexplored_actions
	end

	def set_unexplored_actions( actions )
		@unexplored_actions = actions
	end

	def get_state
		@state
	end

	# Creating the next state given a chosen action
	def next_state
		@unexplored_actions = @state.find_actions
	end

end	
