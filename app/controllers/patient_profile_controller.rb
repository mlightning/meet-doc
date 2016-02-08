class PatientProfileController < ApplicationController
  before_filter :check_auth, :only => [:create, :getbyuser, :update]
  before_filter :validate_profile, :only => [:create, :update]
  before_filter :check_admin, :only => [:delete]


  def create

    @user = User.find_by_username(params[:username])
    @profile = PatientProfile.find_by_userid(@user.id);
    unless @profile.nil?
      render :json => {:success => false, :error => $error_401}
      return
    end
    @dprofile = DoctorProfile.find_by_userid(@user.id);
    unless @dprofile.nil?
      render :json => {:success => false, :error => $error_403}
      return
    end

    @profile = PatientProfile.new
    @profile.userid = @user.id
    @profile.firstname = params[:firstname]
    @profile.lastname = params[:lastname]
    @profile.docpref1 = params[:docpref1]
    @profile.docpref2 = params[:docpref2]
    @profile.docpref3 = params[:docpref3]
    @profile.pcprequest = params[:pcprequest]
    @profile.zipcode = params[:zipcode]

    file = params[:profilepic];
    unless file.nil?
      name = @user.username
      directory = "public/data"
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file))
      end
      @profile.profilepic = path
    end
    @profile.save
    render :json => {:success => true, :data => {:profile_id => @profile.id}}

  end

  def get
    query = params[:query];
    if query.nil? || query == ''
      query = 'id > 0'
    end
    @profiles = PatientProfile.find_by_sql("select * from patient_profiles where #{query}" );
    render :json => {:success => true, :data => @profiles}
  end

  def getbyuser

    @user = User.find_by_username(params[:username])
    if @user.nil?
      render :json => {:success => false, :error => $error_301}
      return
    end

    @profiles = PatientProfile.find_by_userid(@user.id)
    render :json => {:success => true, :data => @profiles}
  end

  def update

    @user = User.find_by_username(params[:username])
    @profile = PatientProfile.find_by_userid(@user.id);
    if @profile.nil?
      render :json => {:success => false, :error => $error_402}
      return
    end

    @profile.firstname = params[:firstname]
    @profile.lastname = params[:lastname]
    @profile.docpref1 = params[:docpref1]
    @profile.docpref2 = params[:docpref2]
    @profile.docpref3 = params[:docpref3]
    @profile.pcprequest = params[:pcprequest]
    @profile.zipcode = params[:zipcode]

    file = params[:profilepic];

    unless file.nil?
      name = @user.username
      directory = "public/data"
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file))
      end
      @profile.profilepic = path
    end


    @profile.save
    render :json => {:success => true, :data => {:profile_id => @profile.id}}

  end


  def delete

    id = params[:id];
    if id.nil?
      render :json => {:success => false, :error => $error_1}
      return
    end

    @profile = PatientProfile.find_by_id(id)

    if @profile.nil?
      render :json => {:success => false, :error => $error_103}
      return
    end

    @profile.destroy
    render :json => {:success => true}
  end

  #to-delete
  def destroyAll
    PatientProfile.destroy_all
    render :json => {:success => true}
  end


  private
  def check_auth
    token = params[:token]
    @session = Session.find_by_token(token);
    if token.nil? || @session.nil?
      render :json => {:success => false, :error => $error_2}
      return;
    end

    params[:username] = @session.username

  end

  def validate_profile

    docpref1 = params[:docpref1]
    docpref2 = params[:docpref2]
    docpref3 = params[:docpref3]
    firstname = params[:firstname]
    lastname = params[:lastname]
    pcprequest = params[:pcprequest]
    zipcode = params[:zipcode]

    if firstname.nil? || firstname == '' || lastname.nil? || lastname == ''
      render :json => {:success => false, :error => $error_1}
      return
    end

    @user = User.find_by_username(params[:username])
    if @user.nil?
      render :json => {:success => false, :error => $error_301}
      return
    end

  end

  def check_admin
    token = params[:token]
    @session = Session.find_by_token(token);
    if token.nil? || @session.nil?
      render :json => {:success => false, :error => $error_2}
      return;
    end

    @user = User.find_by_username(@session.username);
    if @user.nil? || @user.usertype != $admin_usertype
      render :json => {:success => false, :error => $error_3}
      return;
    end

    params[:username] = @session.username

  end
end
