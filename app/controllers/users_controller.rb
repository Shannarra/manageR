class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit destroy update]

  before_action :check_for_current_user!, only: %i[my_profile verify_code]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  def my_profile
    redirect_to verify_code_users_path if has_user_logged_in?
  end

  def verify_code
    redirect_to current_user unless has_user_logged_in?
  end

  def manage
    name = params[:search] || ""

    @users = User
              .where('name ilike ?', "%#{name}%")
              .users_visible_to_me(my_access)
              .order(name: :asc)
              .page(params[:page])
              .per(params[:per_page] || DEFAULT_PER_PAGE)
  end

  # GET /users/new
  def new
    authorize current_user
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize @user

    redirect_to edit_user_registration_path if @user == current_user
  end

  # POST /users
  def create
    @user = User.create(user_registration_sanitized_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to manage_path, notice: 'User was successfully created.' }
      else
        format.html { redirect_to new_user_url, alert: @user.errors.map(&:full_message).join("\n") }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    authorize @user

    respond_to do |format|
      inputed_code = user_params[:institution_code]
      valid_code = @user&.institution&.code

      if inputed_code != valid_code && @user == current_user
        format.html { redirect_to verify_code_users_path, alert: "Verification code does not match with your institution" }
      elsif @user.update(user_params)
        updating_my_profile =  @user == current_user
        path = updating_my_profile ? my_profile_users_path : manage_users_path
        message = updating_my_profile ? 'Verification code successfully confirmed!' : 'User profile successfully updated!'

        format.html { redirect_to path, notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  protected
  def has_user_logged_in?
    current_user.institution_code.nil?
  end

  def my_access
    User.access_visible_to(current_user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      id = params[:id]
      return @user = current_user if id.nil?
      @user = User.find(id)
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User does not exist.' }
      end
    end

    def user_registration_sanitized_params
      params.require(:user).permit(
        :access_type,
        :name,
        :email,
        :password,
        :gender,
        :phone,
        :image,
        :image_cache,
        :institution_code,
        :password,
        :password_confirmation,
        :current_password,
      )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      user_registration_sanitized_params
        .to_h
        .except(
          :password,
          :password_confirmation,
          :current_password
        )
    end

    def check_for_current_user!
      unless current_user
        flash[:alert] = 'You need to be logged in to see your profile page!'
        authenticate_user!
      end
    end
end
