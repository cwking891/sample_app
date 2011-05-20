class UsersController < ApplicationController

  def new
    @user = User.new
    @title = "Sign Up"
  end

  def create

    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
	 # Note that we are repeating ourselves here.
	 # if we simple sent the new action then we get the title
	 # from above, and it would render the new template.
	 # why can't we do that? because we cannot generate a
	 # new request.. we can only prepare response to create request
      @title = "Sign up"
      render 'new'
    end

  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
	
end
