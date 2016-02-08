class User < ActiveRecord::Base
  has_one   :doctor_profile
  attr_accessible :email, :password, :status, :username, :usertype


end
