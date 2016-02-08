class UserController < ApplicationController
   skip_before_filter :verify_authenticity_token

  before_filter :check_auth, :only => [:get, :update]
  before_filter :check_admin, :only => [:delete]
  before_filter :validate_user, :only => [:create]

  def create
    @newUser = User.new
    @newUser.username = params[:username]
    @newUser.email = params[:email]
    password = Digest::MD5.hexdigest(params[:password]);
    @newUser.password = password
    @newUser.usertype = params[:usertype]
    @newUser.status = 1
    @newUser.save

    render :json => {:success => true, :data => {:user_id => @newUser.id}}
  end


  def get
    @user = User.find_by_username(params[:username])

    if @user.nil?
      render :json => {:success => false, :error => $error_103}
      return
    end

    render :json => {:success => true, :data => @user}
  end


  def update
    @user = User.find_by_username(params[:username])

    if @user.nil?
      render :json => {:success => false, :error => $error_103}
      return
    end

    password = params[:password]
    if password.nil? || password == ''
      render :json => {:success => false, :error => $error_1}
      return;
    end

    @user.password = Digest::MD5.hexdigest(params[:password]);
    @user.save
    render :json => {:success => true, :data => @user}

  end


  def delete

    id = params[:id];
    if id.nil?
      render :json => {:success => false, :error => $error_1}
      return
    end

    @user = User.find_by_id(id)

    if @user.nil?
      render :json => {:success => false, :error => $error_103}
      return
    end

    @user.destroy
    render :json => {:success => true}
  end

  #to-delete
  def destroyAll
    User.destroy_all
    render :json => {:success => true}
  end

  #to-delete
  def list
    @users = User.all;
    render :json => {:success => true, :data => @users}
  end

  private

  def validate_user
    p params
    username = params[:username]
    password = params[:password]
    email = params[:email]
    usertype = params[:usertype]

    if username.nil? || username == '' || password.nil? || password == '' || email.nil? || email == '' || usertype.nil? || usertype == ''
      render :json => {:success => false, :error => $error_1}
      return
    end

    @user = User.find_by_username(username)
    if not @user.nil?
      render :json => {:success => false, :error => $error_101}
      return
    end

    @user = User.find_by_email(email)
    if not @user.nil?
      render :json => {:success => false, :error => $error_102}
      return
    end

  end

  def check_auth
    token = params[:token]
    @session = Session.find_by_token(token);
    if token.nil? || @session.nil?
      render :json => {:success => false, :error => $error_2}
      return;
    end

    params[:username] = @session.username

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
