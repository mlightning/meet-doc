Back2::Application.routes.draw do
  #resources :patient_profiles

  match '/user/create', :controller => 'user', :method => 'create'
  match '/user/get', :controller => 'user', :method => 'get'
  match '/user/update', :controller => 'user', :method => 'update'
  match '/user/list', :controller => 'user', :method => 'list'
  match '/user/delete', :controller => 'user', :method => 'delete'
  match '/user/destroyAll', :controller => 'user', :method => 'destroyAll'

  match '/session/create', :controller => 'session', :method => 'create'
  match '/session/list', :controller => 'session', :method => 'list'
  match '/session/destroy', :controller => 'session', :method => 'destroy'
  match '/session/destroyAll', :controller => 'session', :method => 'destroyAll'

  match '/patient_profile/create', :controller => 'patient_profile', :method => 'create'
  match '/patient_profile/update', :controller => 'patient_profile', :method => 'update'
  match '/patient_profile/get', :controller => 'patient_profile', :method => 'get'
  match '/patient_profile/getbyuser', :controller => 'patient_profile', :method => 'getbyuser'
  match '/patient_profile/delete', :controller => 'patient_profile', :method => 'delete'
  match '/patient_profile/destroyAll', :controller => 'patient_profile', :method => 'destroyAll'

  match '/doctor_profile/create', :controller => 'doctor_profile', :method => 'create'
  match '/doctor_profile/update', :controller => 'doctor_profile', :method => 'update'
  match '/doctor_profile/get', :controller => 'doctor_profile', :method => 'get'
  match '/doctor_profile/getbyuser', :controller => 'doctor_profile', :method => 'getbyuser'
  match '/doctor_profile/delete', :controller => 'doctor_profile', :method => 'delete'
  match '/doctor_profile/destroyAll', :controller => 'doctor_profile', :method => 'destroyAll'

  match '/appointment_card/create', :controller => 'appointment_card', :method => 'create'
  match '/appointment_card/get', :controller => 'appointment_card', :method => 'get'
  match '/appointment_card/update', :controller => 'appointment_card', :method => 'update'
  match '/appointment_card/getbyuser', :controller => 'appointment_card', :method => 'getbyuser'
  match '/appointment_card/delete', :controller => 'appointment_card', :method => 'delete'
  match '/appointment_card/destroyAll', :controller => 'appointment_card', :method => 'destroyAll'

  match '/slot/create', :controller => 'slot', :method => 'create'
  match '/slot/get', :controller => 'slot', :method => 'get'
  match '/slot/update', :controller => 'slot', :method => 'update'
  match '/slot/getbyuser', :controller => 'slot', :method => 'getbyuser'
  match '/slot/delete', :controller => 'slot', :method => 'delete'
  match '/slot/destroyAll', :controller => 'slot', :method => 'destroyAll'

  
end
