require File.dirname(__FILE__) + '/../test_helper'

describe "User object" do
	before :each do
		@user = User.new( :name => "Name", :email => "email@email.com", passowrd: "testpass", password_confirmation: "testpass")
	end

	describe "#new" do
		it "takes 2 parameters and returns a User object" do
			@user.should be_an_instance_of User
		end
	end

	describe '#name' do
		it "returns the user name" do
			@user.name.should eq "Name"
		end
	end

	describe '#email' do
		it "returns the email of the user" do
			@user.email.should eq "email@email.com"
		end
	end

	it 'is invalid without a name' do
		User.new(:name => nil, :email => "email@email.com").should_not be_valid
	end

	it 'is invalid without a email' do
		User.new(:name => "Name2", :email => nil).should_not be_valid
	end

	it 'cannot have the email of an existing user' do
		User.create(:name => "Name2", :email => "email@email.com").should_not be_valid
	end

#	it "should accept valid email addresses" do
#    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
#                         first.last@foo.jp alice+bob@baz.cn]
#	    valid_addresses.each do |valid_address|
#	      @user.email = valid_address
#	      @user.valid?.should be true
#    	end
# 	end
end
