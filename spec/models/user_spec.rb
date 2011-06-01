require 'spec_helper'

describe User do

	before (:each) do
	  @rec = {:name=>"Signor Wences",
		    :email=>"finefellow@net.com",
                :password => "mypassword",
                :password_confirmation => "mypassword"}
	end
	
	it "should be created" do
		User.create!(@rec)
	end

  describe "password validations" do

    it "should require a password" do
      User.new(@rec.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@rec.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @rec.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @rec.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end

    it "should have an encrypted password attribute" do
      User.new.should respond_to(:encrypted_password)
    end

  end


  describe "password encryption" do

    before (:each) do
      @user = User.create!(@rec)
    end

    it "should have an encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@rec[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end

    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@rec[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("b@foo.com", @rec[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@rec[:email], @rec[:password])
        matching_user.should == @user
      end

    end

  end # End Password Encryption

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
  ["hello@email.com", "+-.@email.com", "hello@--..com", "hello@email.c", ]
  .each do |email|
    it "allows email in correct format" do
      User.create(@rec.merge(:email => email) ).should be_valid
    end
  end
	
  ["!ello@email.com", "helloemail.com", "hello@_mail.com", "hello@emailcom", "hello@email._om", ]
  .each do |email|
    it "should not allow invalid email format" do
	 user = User.create(@rec.merge(:email => email) )
	 # puts "Email " + user.email + " " + user.valid?.to_s
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
	# puts "Caught Exception " + e.class.to_s + " " +e.to_s
	a.should be_valid
    end
  end
	
  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@rec)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @user
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end
  end


end
