class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if user_signed_in?
      redirect_to user_path(current_user)
    end


  end

  # GET /users/1
  # GET /users/1.json
  def show
    if user_signed_in? && User.find(params[:id]) == current_user
      @topics = []
      @topics_by_num = []
      @user.nonprofits.each do |n|
        @topics << n.main 
      end

      @topics.each do |a|
        @topics_by_num << { 'topic' => a, 'donations' => @topics.count(a)} if !@topics_by_num.include?({  'topic' => a, 'donations' => @topics.count(a)})
      end

      respond_to do |format|
          format.html {@user = User.find(params[:id])}
          format.json { render :json => {data: @topics_by_num} }

      end
    else
       redirect_to users_path
    end 
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if @user != current_user
      redirect_to root_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    params[:user][:topic_ids].each do |a|
      @user.topics << a
    end


    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    response = HTTParty.post("http://usapisandbox.fgdev.net/cardonfile", 
      {:body => {"accountName" => params[:accountName], "ccNumber" => params[:ccNumber], "ccType" => params[:ccType], "ccExpDateMonth" => params[:ccExpDateMonth], "ccExpDateYear" => params[:ccExpDateYear], "billToAddressLine1" => params[:billToAddressLine1], "billToCity" => params[:billToCity], "billToState" => params[:billToState], "billToZip" => params[:billToZip], "ccCardValidationNum" => params[:ccCardValidationNum], "billToFirstName" => params[:billToFirstName], "billToLastName" => params[:billToLastName], "billToCountry" => params[:billToCountry], "billToEmail" => params[:billToEmail], "remoteAddr" => "127.0.0.1"}, 
       :headers => {"JG_APPLICATIONKEY" => "b1d5db6b-1368-49cc-917c-e98758f28b36", "JG_SECURITYTOKEN" => "277ce2dd-7d4e-4bf2-978d-f91af2624fad"}})
    p response.parsed_response["firstGivingDonationApi"]["firstGivingResponse"]["cardOnFileId"]
  
    @user.card_token = response.parsed_response["firstGivingDonationApi"]["firstGivingResponse"]["cardOnFileId"]
    respond_to do |format|
    params[:user][:topic_ids].each do |a|
      if Topic.where(id: a).count > 0
      @user.topics << Topic.find(a)
      end
    end
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :card_token)
    end
end
