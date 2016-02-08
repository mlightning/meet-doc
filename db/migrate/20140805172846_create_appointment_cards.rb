class CreateAppointmentCards < ActiveRecord::Migration
  def change
    create_table :appointment_cards do |t|
      t.string :doctorid
      t.string :doctortoken
      t.string :image1
      t.string :image2
      t.string :image3
      t.string :patientid
      t.string :patienttoken
      t.string :problemdesc
      t.string :problemsummary
      t.integer :rating
      t.string :sessionid
      t.string :slot
      t.string :status

      t.timestamps
    end
  end
end
