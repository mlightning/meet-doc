class SessionController < ApplicationController
  before_filter :check_auth, :only => [:destroy]

  def create
    username = params[:username]
    password = params[:password]

    if username.nil? || password.nil?
      error = {:error_id => 1, :error_message => "fields are missing."}
      render :json => {:success => false, :error => error}
      return
    end

    @user = User.find_by_username(username)
    if @user.nil?
      render :json => {:success => false, :error => $error_201}
      return
    end


    if @user.password != Digest::MD5.hexdigest(password);
      render :json => {:success => false, :error => $error_202}
      return
    end

    @newSession = Session.new
    @newSession.username = username
    @newSession.expiry = Time.new + 1.days
    @newSession.save

    render :json => {:success => true, :data => {:user_id => @user.id, :token => @newSession.token}}

  end

  def destroy

    @session = Session.find_by_token(params[:token]);
    @session.destroy

    render :json => {:success => true}

  end

  #to-delete
  def destroyAll
    Session.destroy_all
    render :json => {:success => true}
  end

  #to-delete
  def list
    @sessions = Session.all;
    render :json => {:success => true, :data => @sessions}
  end


  private
  def check_auth
    token = params[:token]
    @session = Session.find_by_token(token);
    if token.nil? || @session.nil?
      render :json => {:success => false, :error => $error_2}
    end

  end

end
