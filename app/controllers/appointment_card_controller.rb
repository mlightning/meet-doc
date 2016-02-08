class AppointmentCardController < ApplicationController
  before_filter :check_auth, :only => [:get, :create, :getbyuser, :update, :delete]
  before_filter :validate_values, :only => [:create, :update]
  before_filter :check_cardowner, :only => [:update, :delete]


  def create

    @user = User.find_by_username(params[:username])
    @card = AppointmentCards.new
    @card.doctorid = params[:doctorid]
    @card.doctortoken = params[:doctortoken]
    @card.patientid = params[:patientid]
    @card.patienttoken = params[:patienttoken]
    @card.problemdesc = params[:problemdesc]
    @card.problemsummary = params[:problemsummary]
    @card.rating = params[:rating]
    @card.sessionid = params[:sessionid]
    @card.slot = params[:slot]
    @card.status = params[:status]

    #@card.image1 = params[:image1]

    @card.save
    card_id = @card.id
    file1 = params[:image1];
    unless file1.nil?
      name = file1.original_filename
      directory = "public/data/cards/#{card_id}/1/"
      FileUtils.mkpath directory
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file1))
      end
      @card.image1 = path
    end

    file2 = params[:image2];
    unless file2.nil?
      name = file2.original_filename
      directory = "public/data/cards/#{card_id}/2/"
      FileUtils.mkpath directory
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file2))
      end
      @card.image2 = path
    end

    file3 = params[:image3];
    unless file3.nil?
      name = file3.original_filename
      directory = "public/data/cards/#{card_id}/3/"
      FileUtils.mkpath directory
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file3))
      end
      @card.image3 = path
    end

    @card.save
    render :json => {:success => true, :data => {:card_id => card_id}}

  end

  def get
    @user = User.find_by_username(params[:username])
    userid = @user.id
    queryd = "(doctorid = '#{userid}' or patientid = '#{userid}') "
    query = params[:query];
    if query.nil? || query == ''
      query = 'id > 0'
    end
    @cards = AppointmentCards.find_by_sql("select * from appointment_cards where  #{queryd} and  #{query}" )
    render :json => {:success => true, :data => @cards}
  end

  def getbyuser
    @user = User.find_by_username(params[:username])
    userid = @user.id
    query = "doctorid = '#{userid}' or patientid = '#{userid}' "
    @cards = AppointmentCards.find_by_sql("select * from appointment_cards where #{query}" )
    render :json => {:success => true, :data => @cards}
  end

  def update

    id = params[:id]
    @card = AppointmentCards.find id
    @card.doctorid = params[:doctorid]
    @card.doctortoken = params[:doctortoken]
    @card.patientid = params[:patientid]
    @card.patienttoken = params[:patienttoken]
    @card.problemdesc = params[:problemdesc]
    @card.problemsummary = params[:problemsummary]
    @card.rating = params[:rating]
    @card.sessionid = params[:sessionid]
    @card.slot = params[:slot]
    @card.status = params[:status]

    @card.save
    card_id = @card.id
    file1 = params[:image1];
    unless file1.nil?
      name = file1.original_filename
      directory = "public/data/cards/#{card_id}/1/"
      FileUtils.mkpath directory
      # create the file path
      path = File.join(directory, name)
      # write the file

      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file1))
      end
      @card.image1 = path
    end

    file2 = params[:image2];
    unless file2.nil?
      name = file2.original_filename
      directory = "public/data/cards/#{card_id}/2/"
      FileUtils.mkpath directory
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file2))
      end
      @card.image2 = path
    end

    file3 = params[:image3];
    unless file3.nil?
      name = file3.original_filename
      directory = "public/data/cards/#{card_id}/3/"
      FileUtils.mkpath directory
      # create the file path
      path = File.join(directory, name)
      # write the file
      File.open(path, 'wb') do|f|
        f.write(Base64.decode64(file3))
      end
      @card.image3 = path
    end


    @card.save
    render :json => {:success => true, :data => {:card_id => @card.id}}

  end


  def delete

    id = params[:id]
    @card = AppointmentCards.find id
    @card.destroy

    render :json => {:success => true}
  end

  #to-delete
  def destroyAll
    AppointmentCards.destroy_all
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

  def check_cardowner

    id = params[:id]
    if id.nil? || id == ''
      render :json => {:success => false, :error => $error_1}
      return
    end

    begin
      @card = AppointmentCards.find id
      if @card.nil?
        render :json => {:success => false, :error => $error_601}
        return
      end

      @user = User.find_by_username(params[:username])
      if @user.id.to_s != @card.doctorid.to_s && @user.id.to_s != @card.patientid.to_s
        render :json => {:success => false, :error => $error_602}
        return
      end
    rescue
      render :json => {:success => false, :error => $error_601}
      return
    end


  end

  def validate_values

    doctorid = params[:doctorid]
    doctortoken = params[:doctortoken]
    patientid = params[:patientid]
    patienttoken = params[:patienttoken]
    problemdesc = params[:problemdesc]
    problemsummary = params[:problemsummary]
    rating = params[:rating]
    sessionid = params[:sessionid]
    slot = params[:slot]
    status = params[:status]

    # if firstname.nil? || firstname == '' || lastname.nil? || lastname == '' || speciality.nil? || speciality == '' || about.nil? || about == '' || schedule.nil? || schedule == '' || zipcode.nil? || zipcode == ''
    #   render :json => {:success => false, :error => $error_1}
    #   return
    # end

    @user = User.find_by_username(params[:username])
    if @user.nil?
      render :json => {:success => false, :error => $error_301}
      return
    end

  end

end
