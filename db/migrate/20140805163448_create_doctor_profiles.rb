class CreateDoctorProfiles < ActiveRecord::Migration
  def change
    create_table :doctor_profiles do |t|
      t.string :about
      t.string :firstname
      t.string :lastname
      t.string :profilepic
      t.string :schedule
      t.string :speciality
      t.string :title
      t.string :userid
      t.string :zipcode

      t.timestamps
    end
  end
end
