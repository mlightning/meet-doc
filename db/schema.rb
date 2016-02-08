# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140806171715) do

  create_table "appointment_cards", :force => true do |t|
    t.string   "doctorid"
    t.string   "doctortoken"
    t.string   "image1"
    t.string   "image2"
    t.string   "image3"
    t.string   "patientid"
    t.string   "patienttoken"
    t.string   "problemdesc"
    t.string   "problemsummary"
    t.integer  "rating"
    t.string   "sessionid"
    t.string   "slot"
    t.string   "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "doctor_profiles", :force => true do |t|
    t.string   "about"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "profilepic"
    t.string   "schedule"
    t.string   "speciality"
    t.string   "title"
    t.string   "userid"
    t.string   "zipcode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "patient_profiles", :force => true do |t|
    t.string   "userid"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "pcprequest"
    t.string   "profilepic"
    t.string   "zipcode"
    t.integer  "docpref1"
    t.integer  "docpref2"
    t.integer  "docpref3"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "username"
    t.string   "token"
    t.datetime "expiry"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "slots", :force => true do |t|
    t.datetime "date"
    t.string   "doctorid"
    t.string   "schedule"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.integer  "usertype"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
