class GradingSystemsController < ApplicationController
  before_action :set_grading_system, only: %i[ show edit update destroy ]

  # GET /grading_systems or /grading_systems.json
  def index
    @grading_systems = GradingSystem.all
  end

  # GET /grading_systems/1 or /grading_systems/1.json
  def show
  end

  # GET /grading_systems/new
  def new
    @grading_system = GradingSystem.new
  end

  # GET /grading_systems/1/edit
  def edit
  end

  # POST /grading_systems or /grading_systems.json
  def create
    @grading_system = GradingSystem.new(grading_system_params)

    respond_to do |format|
      if @grading_system.save
        format.html { redirect_to grading_system_url(@grading_system), notice: "Grading system was successfully created." }
        format.json { render :show, status: :created, location: @grading_system }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @grading_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grading_systems/1 or /grading_systems/1.json
  def update
    respond_to do |format|
      if @grading_system.update(grading_system_params)
        format.html { redirect_to grading_system_url(@grading_system), notice: "Grading system was successfully updated." }
        format.json { render :show, status: :ok, location: @grading_system }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @grading_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grading_systems/1 or /grading_systems/1.json
  def destroy
    @grading_system.destroy

    respond_to do |format|
      format.html { redirect_to grading_systems_url, notice: "Grading system was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grading_system
      @grading_system = GradingSystem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def grading_system_params
      params.require(:grading_system).permit(
        :name,
        :start_grade,
        :end_grade,
        :step,
        :direction,
        :description,
        :possible_grades,
        :institution_id)
    end
end
