class DoctorProfile < ActiveRecord::Base
  belongs_to  :user
  attr_accessible :about, :firstname, :lastname, :profilepic, :schedule, :speciality, :title, :userid, :zipcode
end
