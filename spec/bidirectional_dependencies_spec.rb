require "spec_helper"

RSpec.describe Resolver, "with bidirectional dependencies" do
  let(:resolver) { Resolver.new }
  let(:topics) { Node.new("Topics") }
  let(:oil_and_gas) { Node.new("Oil and gas") }
  let(:fields_and_wells) { Node.new("Fields and wells") }
  let(:geo_data_guide) { Node.new("Geoscientific data guide")}

  before do
    resolver.add_dependency(dependent: topics, dependee: oil_and_gas)
    resolver.add_dependency(dependent: oil_and_gas, dependee: topics)
  end

  describe "#dependees(node)" do
    it "returns all nodes which are depended on by the given node" do
      expect(resolver.dependees(topics)).to eq([oil_and_gas].to_set)
      expect(resolver.dependees(oil_and_gas)).to eq([topics].to_set)
    end
  end

  describe "#dependents(node)" do
    it "returns all nodes which depend on the given node" do
      expect(resolver.dependents(topics)).to eq([oil_and_gas].to_set)
      expect(resolver.dependents(oil_and_gas)).to eq([topics].to_set)
    end
  end

  context "when the dependency between 'oil_and_gas' and 'topics' is removed" do
    before do
      resolver.remove_dependency(dependent: oil_and_gas, dependee: topics)
    end

    describe "#dependees(node)" do
      it "returns all nodes which are depended on by the given node" do
        expect(resolver.dependees(topics)).to eq([oil_and_gas].to_set)
        expect(resolver.dependees(oil_and_gas)).to eq([].to_set)
      end
    end

    describe "#dependents(node)" do
      it "returns all nodes which depend on the given node" do
        expect(resolver.dependents(topics)).to eq([].to_set)
        expect(resolver.dependents(oil_and_gas)).to eq([topics].to_set)
      end
    end
  end

  context "when the dependency between 'topics' and 'oil_and_gas' is removed" do
    before do
      resolver.remove_dependency(dependent: topics, dependee: oil_and_gas)
    end

    describe "#dependees(node)" do
      it "returns all nodes which are depended on by the given node" do
        expect(resolver.dependees(topics)).to eq([].to_set)
        expect(resolver.dependees(oil_and_gas)).to eq([topics].to_set)
      end
    end

    describe "#dependents(node)" do
      it "returns all nodes which depend on the given node" do
        expect(resolver.dependents(topics)).to eq([oil_and_gas].to_set)
        expect(resolver.dependents(oil_and_gas)).to eq([].to_set)
      end
    end
  end
end
