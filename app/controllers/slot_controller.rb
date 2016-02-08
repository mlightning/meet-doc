class SlotController < ApplicationController
  before_filter :check_auth, :only => [:get, :create, :getbyuser, :update, :delete]
  before_filter :validate_values, :only => [:create, :update]

  def create

    @user = User.find_by_username(params[:username])
    @slot = Slot.new
    @slot.doctorid = @user.id
    @slot.schedule = params[:schedule]
    @slot.date = params[:date]

    @slot.save
    render :json => {:success => true, :data => {:slot_id => @slot.id}}

  end

  def get
    query = params[:query];
    if query.nil? || query == ''
      query = 'id > 0'
    end
    @slots = Slot.find_by_sql("select * from slots where  #{query}" )
    render :json => {:success => true, :data => @slots}
  end

  def getbyuser
    @user = User.find_by_username(params[:username])
    @slots = Slot.find_all_by_doctorid(@user.id)
    render :json => {:success => true, :data => @slots  }
end

  def update

    id = params[:id]
    if id.nil? || id == ''
      render :json => {:success => false, :error => $error_1}
      return
    end

    begin
      @slot = Slot.find id
      @slot.date = params[:date]
      @slot.schedule = params[:schedule]

      @slot.save

      render :json => {:success => true, :data => {:slot_id => @slot.id}}
    rescue
      render :json => {:success => false, :error => $error_701}
      return
    end

  end


  def delete

    id = params[:id]
    @slot = Slot.find id
    @slot.destroy

    render :json => {:success => true}
  end

  #to-delete
  def destroyAll
    Slot.destroy_all
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


  def validate_values

    date = params[:date]
    schedule = params[:schedule]

    if date.nil? || date == '' || schedule.nil? || schedule == ''
      render :json => {:success => false, :error => $error_1}
      return
    end

    @user = User.find_by_username(params[:username])
    if @user.nil?
      render :json => {:success => false, :error => $error_301}
      return
    end

  end

end
