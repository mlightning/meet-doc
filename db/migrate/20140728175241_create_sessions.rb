class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :username
      t.string :token
      t.datetime :expiry
      t.timestamps
    end
  end
end
