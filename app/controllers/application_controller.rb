$admin_usertype = 1

$error_1 = {:error_id => 1, :error_message => "required fields are missing."}
$error_2 = {:error_id => 2, :error_message => "wrong token."}
$error_3 = {:error_id => 3, :error_message => "admin previlege required."}

$error_101 = {:error_id => 101, :error_message => "user name is already taken."}
$error_102 = {:error_id => 102, :error_message => "email is already taken."}
$error_103 = {:error_id => 103, :error_message => "no user data found."}


$error_201 = {:error_id => 201, :error_message => "no username found."}
$error_202 = {:error_id => 202, :error_message => "password is not correct."}

$error_301 = {:error_id => 301, :error_message => "no user data found."}

$error_401 = {:error_id => 401, :error_message => "patient profile is already found."}
$error_402 = {:error_id => 402, :error_message => "patient profile not found."}
$error_403 = {:error_id => 403, :error_message => "this user already has a doctor profile."}

$error_501 = {:error_id => 501, :error_message => "doctor profile is already found."}
$error_502 = {:error_id => 502, :error_message => "doctor profile not found."}
$error_503 = {:error_id => 503, :error_message => "this user already has a patient profile."}

$error_601 = {:error_id => 601, :error_message => "can't find the card."}
$error_602 = {:error_id => 602, :error_message => "can't access this appointment."}

$error_701 = {:error_id => 601, :error_message => "can't find the slot."}

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  before_filter :take_jsonbody
  private
  def take_jsonbody
    params.merge! ActiveSupport::JSON.decode(request.body.string)

end
