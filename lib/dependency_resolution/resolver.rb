require 'rgl/adjacency'
require 'rgl/traversal'

module DependencyResolution
  class Resolver
    attr_accessor :graph

    def initialize
      self.graph = RGL::DirectedAdjacencyGraph.new
    end

    def add_dependency(dependent:, dependee:)
      graph.add_edge(dependent, dependee)
    end

    def remove_dependency(dependent:, dependee:)
      graph.remove_edge(dependent, dependee)
    end

    def dependents(start_node)
      subgraph = graph.reverse.bfs_search_tree_from(start_node)
      subgraph.vertices.to_set.delete(start_node)
    end

    def dependees(start_node)
      subgraph = graph.bfs_search_tree_from(start_node)
      subgraph.vertices.to_set.delete(start_node)
    end
  end
end
