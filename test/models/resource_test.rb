require File.dirname(__FILE__) + '/../test_helper'

describe "Resource object" do
	before :each do
		@resource = Resource.new( :name => "Name", :description => "Description", :numberOf => 50)
	end

	describe "#new" do
		it "takes three parameters and returns a Resource object" do
			@resource.should be_an_instance_of Resource
		end
	end

	describe '#name' do
		it "returns the resource name" do
			@resource.name.should eq "Name"
		end
	end

	describe '#Description' do
		it "returns the decription of the resource" do
			@resource.description.should eq "Description"
		end
	end

	describe '#numberOf' do
		it "how many of the resources are available" do
			@resource.numberOf.should equal 50
		end
	end

	it 'is invalid without a name' do
		Resource.new(:name => nil, :description => "Description", :numberOf => 50).should_not be_valid
	end

	it 'cannot have the name of an existing resource' do
		Resource.create(:name => "Name", :description => "Description", :numberOf => 50).should_not be_valid
	#context "if resource with name 'name' exists" do
	#	before do
	#		Resource.create!(:name => "Name", :description => "Description", :numberOf => 50)
	#	end
	#	it { should_not accept_values_for(:name, "Name") }
	#end
	end

end
