class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:new, :create]
  before_filter :authenticate_activation!, :except => [:new, :create]
  before_filter :skip_password_attribute, only: :update
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def edit_password
    @user = current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        login @user
        format.html { redirect_to @user, notice: 'You will receive an email when account is activated.' }
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
    respond_to do |format|
      if @user.update(update_user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to @user, danger: "Unable to edit user" }
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

  def update_password
    @user = User.find_by(email: params[:email])
    respond_to do |format|
      if @user.update(password_params)
        format.html { redirect_to @user, notice: "Password successfully changed" }
        format.json { render :show, status: :ok, location: @user }
  #     UserMailer.account_activation(@user).deliver_now
      else
        format.html { render :edit_password }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def activate
    set_user
    @user.activated = true;
    @user.save!
    UserMailer.account_activation(@user).deliver_now
    redirect_to admin_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :home_group, :user_level, :activated)
    end

    def update_user_params
      params.require(:user).permit(:name, :email, :phone, :home_group, :user_level, :activated)
    end

    def password_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def skip_password_attribute
      if params[:password].blank? && params[:password_confirmation].blank?
        params.except!(:password, :v)
      end
  end
end
