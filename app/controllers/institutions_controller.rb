class InstitutionsController < ApplicationController
  before_action :set_institution, only: %i[show]

  def show
    authorize @institution
  end

  private
  def institution_params
    params.require(:institution).permit(:name, :location)
  end

  def set_institution
    @institution = Institution.find(params[:institution_id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to root_url } #, notice: 'Institution does not exist or you don\'t have access.' }
    end
  end
end
