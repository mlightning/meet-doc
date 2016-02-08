class PatientProfile < ActiveRecord::Base
  attr_accessible :docpref1, :docpref2, :docpref3, :firstname, :lastname, :pcprequest, :profilepic, :userid, :zipcode
end
