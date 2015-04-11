require File.dirname(__FILE__) + '/../test_helper'

describe "Facility object" do
	before :each do
		@facility = Facility.new( :name => "Name", :description => "Description", :capacity => 50)
	end

	describe "#new" do
		it "takes three parameters and returns a Facility object" do
			@facility.should be_an_instance_of Facility
		end
	end

	describe '#name' do
		it "returns the Facility name" do
			@facility.name.should eq "Name"
		end
	end

	describe '#Description' do
		it "returns the decription of the facility" do
			@facility.description.should eq "Description"
		end
	end

	describe '#capacity' do
		it "returns the Facility's capacity" do
			@facility.capacity.should equal 50
		end
	end

	it 'is invalid without a name' do
		Facility.new(:name => nil, :description => "Description", :capacity => 50).should_not be_valid
	end

	it 'cannot have the name of an existing facility' do
		Facility.create(:name => "Name", :description => "Description", :capacity => 50).should_not be_valid
	end

end
