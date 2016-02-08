class DoctorProfileController < ApplicationController
  before_filter :check_auth, :only => [:create, :getbyuser, :update]
  before_filter :validate_profile, :only => [:create, :update]
  before_filter :check_admin, :only => [:delete]


  def create

    @user = User.find_by_username(params[:username])
    @profile = DoctorProfile.find_by_userid(@user.id);
    unless @profile.nil?
      render :json => {:success => false, :error => $error_501}
      return
    end
    @pprofile = PatientProfile.find_by_userid(@user.id);
    unless @pprofile.nil?
      render :json => {:success => false, :error => $error_503}
      return
    end

    @profile = DoctorProfile.new
    @profile.userid = @user.id
    @profile.firstname = params[:firstname]
    @profile.lastname = params[:lastname]
    @profile.speciality = params[:speciality]
    @profile.about = params[:about]
    @profile.schedule = params[:schedule]
    @profile.title = params[:title]
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
    @profiles = DoctorProfile.find_by_sql("select * from doctor_profiles where #{query}" );
    render :json => {:success => true, :data => @profiles}
  end

  def getbyuser

    @user = User.find_by_username(params[:username])
    if @user.nil?
      render :json => {:success => false, :error => $error_301}
      return
    end

    @profiles = DoctorProfile.find_by_userid(@user.id)
    render :json => {:success => true, :data => @profiles}
  end

  def update

    @user = User.find_by_username(params[:username])
    @profile = DoctorProfile.find_by_userid(@user.id);
    if @profile.nil?
      render :json => {:success => false, :error => $error_502}
      return
    end

    @profile.userid = @user.id
    @profile.firstname = params[:firstname]
    @profile.lastname = params[:lastname]
    @profile.speciality = params[:speciality]
    @profile.about = params[:about]
    @profile.schedule = params[:schedule]
    @profile.title = params[:title]
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

    @profile = DoctorProfile.find_by_id(id)

    if @profile.nil?
      render :json => {:success => false, :error => $error_103}
      return
    end

    @profile.destroy
    render :json => {:success => true}
  end

  #to-delete
  def destroyAll
    DoctorProfile.destroy_all
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

    firstname = params[:firstname]
    lastname = params[:lastname]
    speciality = params[:speciality]
    about = params[:about]
    schedule = params[:schedule]
    title = params[:title]
    zipcode = params[:zipcode]

    if firstname.nil? || firstname == '' || lastname.nil? || lastname == '' || speciality.nil? || speciality == '' || about.nil? || about == '' || schedule.nil? || schedule == '' || zipcode.nil? || zipcode == ''
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
