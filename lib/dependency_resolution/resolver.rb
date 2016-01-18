module DependencyResolution
  class Resolver
    attr_accessor :dependencies

    def initialize
      self.dependencies = Set.new
    end

    def add_dependency(dependent:, dependee:)
      return if dependent == dependee || dependencies.include?([dependent, dependee])

      dependencies << [dependent, dependee]
      
      dependees(dependee).each do |node|
        add_dependency(
          dependent: dependent,
          dependee: node
        )
      end

      dependents(dependent).each do |node|
        add_dependency(
          dependent: node,
          dependee: dependee
        )
      end
    end

    def dependents(dependee_to_filter_by)
      dependencies.map {|(dependent, dependee)|
        dependent if dependee == dependee_to_filter_by
      }.compact.to_set
    end

    def dependees(dependent_to_filter_by)
      dependencies.map {|(dependent, dependee)|
        dependee if dependent == dependent_to_filter_by
      }.compact.to_set
    end
  end
end
