class CreatePatientProfiles < ActiveRecord::Migration
  def change
    create_table :patient_profiles do |t|
      t.string :userid
      t.string :firstname
      t.string :lastname
      t.string :pcprequest
      t.string :profilepic
      t.string :zipcode
      t.integer :docpref1
      t.integer :docpref2
      t.integer :docpref3

      t.timestamps
    end
  end
end
