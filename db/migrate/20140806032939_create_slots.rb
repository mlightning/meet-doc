class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :date
      t.string :doctorid
      t.string :schedule

      t.timestamps
    end
  end
end
