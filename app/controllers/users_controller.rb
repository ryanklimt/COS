class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(:username=>params[:username], :password=>params[:password], :confirmation=>params[:confirmation])
    render 'new'
  end
end
