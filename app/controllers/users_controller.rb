class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def my_profile
    unless current_user
      flash[:alert] = 'You need to be logged in to see your profile page!'
      authenticate_user!
    end
  end

  def manage
    if params[:search]
      results_for_search
    else
      @users = User.all
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

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
    # TODO:
    #authorize @user

    respond_to do |format|
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
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User does not exist.' }
        format.json { head :no_content, status: :not_found }
      end
    end

    def results_for_search
      @users = User.select do |user|
        user.name.downcase.include? params[:search]
      end.to_a
    end

    def user_sanitized_params
      params.require(:user).permit(
        :access_type,
        :name,
        :email,
        :password,
        :gender,
        :phone,
        :image,
        :image_cache,
        :password,
        :password_confirmation,
        :current_password,
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      user_sanitized_params
        .to_h
        .except(
          :password,
          :password_confirmation,
          :current_password
        )
    end
end
