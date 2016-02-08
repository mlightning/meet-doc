class AppointmentCards < ActiveRecord::Base
  attr_accessible :doctorid, :doctortoken, :image1, :image2, :image3, :patientid, :patienttoken, :problemdesc, :problemsummary, :rating, :sessionid, :slot, :status
end
