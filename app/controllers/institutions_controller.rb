class InstitutionsController < ApplicationController
  before_action :set_institution, only: %i[show]

  def index
    redirect_to institution_url(institution_name: current_user.institution.name)
  end

  def show
    if current_user.institution_code.nil?
      redirect_to verify_code_users_path, alert: 'You need to verify your institution before accessing it!'
    else
      authorize @institution
    end
  end

  def manage
    authorize current_user

    name = params[:search] || ""

    @institutions = Institution
               .where('name ilike ?', "%#{name}%")
               .order(name: :asc)
               .page(params[:page])
               .per(params[:per_page] || DEFAULT_PER_PAGE)
  end

  private
  def institution_params
    params.require(:institution).permit(:name, :location)
  end

  def set_institution
    @institution = Institution.find_by_name(params[:institution_name]) || current_user.institution
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to root_url, alert: 'Institution does not exist or you don\'t have access.' }
    end
  end
end
