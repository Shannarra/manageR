class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit destroy]

  before_action :check_for_current_user!, only: %i[my_profile verify_code]

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
    redirect_to verify_code_path if has_user_logged_in?
  end

  def verify_code
    redirect_to current_user unless has_user_logged_in?
  end

  def manage
    name = params[:search] || ""

    @users = User
              .where('name ilike ?', "%#{name}%")
              .users_visible_to_me(my_access)
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
  # POST /users.json
  def create
    @user = User.create(user_registration_sanitized_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to manage_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_to new_user_url, alert: @user.errors.map(&:full_message).join("\n") }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = current_user
    authorize @user

    respond_to do |format|
      # example code: LR9dWXG7Q0jYft6NsiZq
      code = user_params[:institution_code]

      if code != @user.institution.code
        format.html { redirect_to verify_code_path, alert: 'Verification code does not match' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      else
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'Institution code was successfully verified.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
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
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User does not exist.' }
        format.json { head :no_content, status: :not_found }
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
