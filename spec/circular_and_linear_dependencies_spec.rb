require "spec_helper"

RSpec.describe Resolver, "with a mix of circular and linear dependencies" do
  let(:resolver) { Resolver.new }
  let(:topics) { Node.new("Topics") }
  let(:oil_and_gas) { Node.new("Oil and gas") }
  let(:fields_and_wells) { Node.new("Fields and wells") }
  let(:geo_data_guide) { Node.new("Geoscientific data guide")}

  before do
    # Circular dependency
    resolver.add_dependency(dependent: topics, dependee: oil_and_gas)
    resolver.add_dependency(dependent: oil_and_gas, dependee: topics)

    # Linear dependency
    resolver.add_dependency(dependent: fields_and_wells, dependee: oil_and_gas)
  end

  describe "#dependees(node)" do
    it "returns all nodes which are depended on by the given node" do
      expect(resolver.dependees(topics)).to eq([oil_and_gas].to_set)
      expect(resolver.dependees(oil_and_gas)).to eq([topics].to_set)
      expect(resolver.dependees(fields_and_wells)).to eq([topics, oil_and_gas].to_set)
    end
  end

  describe "#dependents(node)" do
    it "returns all nodes which depend on the given node" do
      expect(resolver.dependents(topics)).to eq([oil_and_gas, fields_and_wells].to_set)
      expect(resolver.dependents(oil_and_gas)).to eq([topics, fields_and_wells].to_set)
      expect(resolver.dependents(fields_and_wells)).to eq([].to_set)
    end
  end
end
