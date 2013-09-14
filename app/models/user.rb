class User < ActiveRecord::Base
  attr_accessor :username, :password, :confirmation
end
