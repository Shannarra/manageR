class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy download]

  before_action :sanitize_params

  # GET /reports or /reports.json
  def index
    @reports = Report.for_institution(current_user.institution)
    authorize @reports
  end

  def download
    send_file @report.file.path, type: "application/#{@report.format}"
  end

  # GET /reports/1 or /reports/1.json
  def show
    authorize @report
  end

  # GET /reports/new
  def new
    @report = Report.new
    authorize @report
  end

  # GET /reports/1/edit
  def edit
    authorize @report
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)
    authorize @report

    respond_to do |format|
      if @report.save
        format.html {
 redirect_to reports_url(@report, institution_name: @report.institution.name), notice: "Report was successfully requested." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    authorize @report
    respond_to do |format|
      if @report.update(report_params)
        format.html {
 redirect_to report_url(@report, institution_name: @report.institution.name), notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:report_id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:name, :institution_id, :creation_scope, :by_id, :format)
    end

    def sanitize_params
      if params[:report]
        params[:report][:creation_scope] = params[:report][:creation_scope].to_i
        params[:report][:format] = params[:report][:format].to_i
      end
    end
end
