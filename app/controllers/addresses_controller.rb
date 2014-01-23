class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_filter :verify_is_admin, only: [:show, :edit, :update, :destroy, :index]

  # GET /addresses
  # GET /addresses.json
  
  def choose_address
     user_num = params[:user_id]

     @addresses = Address.where(user_id: user_num)

  end

  def add_address
    @address = Address.new
  end

  def add_address_create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to choose_address_path(current_user.id), notice: 'The address was successfully added.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_address_delete
    address_id = params[:address_id]

    @address = Address.find(address_id)
    @address.destroy
    respond_to do |format|
      format.html { redirect_to choose_address_path(current_user.id), notice: 'The address was deleted.' }
      format.json { head :no_content }  
    end
  end

  def add_address_edit
    address_id = params[:address_id]
    @address = Address.find(address_id)
  end

  def add_address_update 
    address_id = params[:address_id]
    @address = Address.find(address_id)

    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to choose_address_path(current_user.id), notice: 'The address was updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end


  def index
    @addresses = Address.all
  end

  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new

  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses
  # POST /addresses.json
  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to @address, notice: 'Address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @address }
      else
        format.html { render action: 'new' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1
  # PATCH/PUT /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: 'Address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to addresses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def address_params
      params.require(:address).permit(:name, :address1, :address2, :city, :state, :zip, :user_id)
    end

    def verify_is_admin
    (current_user.nil?) ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
    end
end
