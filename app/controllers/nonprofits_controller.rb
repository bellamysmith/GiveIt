class NonprofitsController < ApplicationController
  before_action :set_nonprofit, only: [:show, :edit, :update, :destroy]

  # GET /nonprofits
  # GET /nonprofits.json
  def index
    @nonprofits = Nonprofit.all.shuffle
    @featured = Nonprofit.all.sample  
  end

  # GET /nonprofits/1
  # GET /nonprofits/1.json
  def show

      @donation_count =  @nonprofit.donations.count

    dates = []
    @nonprofit.donations.each do |a|
      dates << a.created_at.day
    end
    @donations = []
    @donations_by_date = []

      for i in (0..6) 
        date = Date.today - i
        @donations << date
      end

      @donations.reverse.each do |a|
        @donations_by_date << { 'date' => a, 'donations' => dates.count(a.day)} if !@donations_by_date.include?({  'date' => a, 'donations' => @donations.count(a)})
      end
    
      
    respond_to do |format|
          format.html {@user = Nonprofit.find(params[:id])}
          format.json { render :json => {data: @donations_by_date} }
    end
  end

  # GET /nonprofits/new
  def new
    @nonprofit = Nonprofit.new
  end

  def profile
    @nonprofit = Nonprofit.find(params[:id])
  end

  # GET /nonprofits/1/edit
  def edit
     if @user != current_user
      redirect_to root_path
    end
  end

  # POST /nonprofits
  # POST /nonprofits.json
  def create

    @nonprofit = Nonprofit.new(nonprofit_params)
      #There is a blank id with the multiple select field, so I have to go through and push them individually into the Nonprofit's topics
      params[:nonprofit][:topic_ids].each do |a|
        if Topic.where(id: a).count > 0
          @nonprofit.topics << Topic.find(a)
        end
      end
      #main topic param needs to be changed to an integer:
      @nonprofit.main_topic = params[:nonprofit][:main_topic].to_i
    respond_to do |format|
      if @nonprofit.save
        format.html { redirect_to @nonprofit, notice: 'Nonprofit was successfully created.' }
        format.json { render :show, status: :created, location: @nonprofit }
      else
        format.html { render :new }
        format.json { render json: @nonprofit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nonprofits/1
  # PATCH/PUT /nonprofits/1.json
  def update
    respond_to do |format|
      #Delete all of the topics to update with new ones
      @nonprofit.topics.delete_all
      #There is a blank id with the multiple select field, so I have to go through and push them individually into the Nonprofit's topics
      params[:nonprofit][:topic_ids].each do |a|
        if Topic.where(id: a).count > 0
          @nonprofit.topics << Topic.find(a)
        end
      end
      #main topic param needs to be changed to an integer:
      @nonprofit.main_topic = params[:nonprofit][:main_topic].to_i

      if @nonprofit.update(nonprofit_params)
        format.html { redirect_to nonprofit_path(@nonprofit), notice: 'Nonprofit was successfully created!' }
        format.json { render :show, status: :ok, location: @nonprofit }
      else
        format.html { render :edit }
        format.json { render json: @nonprofit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nonprofits/1
  # DELETE /nonprofits/1.json
  def destroy
    @nonprofit.destroy
    respond_to do |format|
      format.html { redirect_to nonprofits_url, notice: 'Nonprofit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nonprofit
      @nonprofit = Nonprofit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nonprofit_params
      params.require(:nonprofit).permit(:name, :email, :description, :website, :city, :state, :phone, :topic_id, :main_topic, :ein, :logo, :uuid)
    end
end
