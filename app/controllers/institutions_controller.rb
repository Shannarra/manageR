class InstitutionsController < InheritedResources::Base

  private

    def institution_params
      params.require(:institution).permit(:name, :location)
    end

end
