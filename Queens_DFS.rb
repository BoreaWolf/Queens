#!/usr/bin/env ruby
# N Queens problem solved with the DFS Algorithm

require_relative "Board.rb"
require_relative "DFS.rb"
DEBUG = FALSE

number_of_queens = ( ARGV[ 0 ] || 8 ).to_i
puts "Hello World bitches, we are the #{number_of_queens} Queens."

solver = DFS.new( number_of_queens )
if DEBUG
	puts "Start #{solver.plot_solution}"
end


start_time = Time.now
solver.DFS_solution
end_time = Time.now
puts "Time: #{ end_time - start_time } seconds"
puts "Solution:" 
solver.plot_prettier_solution
# Plots the path to get to the solution, could be huge to plot with huge boards
# puts "Graph: #{solver.plot_graph}"
