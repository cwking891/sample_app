require 'spec_helper'

describe User do

	before (:each) do
		@rec = {:name=>"Signor Wences", :email=>"finefellow@net.com"}
	end
	
	it "should be created" do
		User.create!(@rec)
	end

  it "has name" do
		user = User.create(@rec.merge(:name => "") ).should_not be_valid
	end
	
	 it "has name < 40 characters" do
		 User.create(@rec.merge(:name => "x" * 41) ).should_not be_valid
	 end

  it "has email" do
		User.create(@rec.merge(:email => "") ).should_not be_valid
	end

# Email format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
# Start with any sequence of chars,digits,plus,minus or dots
# followed by @
# followed by any sequence of chars,digits,,minus,dots
# followed by .
# followed by any sequence of chars
# This is not really a good regex.. look at the silly emails it allows!
	["hello@email.com", "+-.@email.com", "hello@--..com", "hello@email.c", ]
	.each do |email|
		it "allows email in correct format" do
				User.create(@rec.merge(:email => email) ).should be_valid
		end
	end
	
	["!ello@email.com", "helloemail.com", "hello@_mail.com", "hello@emailcom", "hello@email._om", ].each do |email|
		it "should not allow invalid email format" do
			user = User.create(@rec.merge(:email => email) )
			puts "Email " + user.email + " " + user.valid?.to_s
			user.should_not be_valid
		end
	end
	
	#Trying to write duplicate record is not caught by model validators.
	#It causes ActiveRecord to throw an Exception
	it "should check for duplicate key on email" do
		a = User.create!(@rec)
		begin
			user = User.create(@rec)
			# allowed it
			user.should eql(nil)
		rescue ActiveRecord::RecordNotUnique => e #user is nil
		  puts "Caught Exception " + e.class.to_s + " " +e.to_s
			a.should be_valid
		end
	end
	
end
