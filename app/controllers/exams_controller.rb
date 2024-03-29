class ExamsController < ApplicationController
  before_action :set_exam, only: %i[show edit update destroy ]

  # GET /exams or /exams.json
  def index
    @exams = Exam.all.user_exams(current_user)
    authorize @exams
  end

  def upcoming
    @exams = Exam.upcoming.user_exams(current_user)
  end

  def show
    authorize @exam
  end

  # GET /exams/new
  def new
    @exam = Exam.new
    authorize @exam
  end

  # GET /exams/1/edit
  def edit
    authorize @exam
  end

  # POST /exams or /exams.json
  def create
    @exam = Exam.new(exam_params)
    @exam.institution_id = exam_params.fetch(:institution_id, current_user.institution_id)
    authorize @exam

    respond_to do |format|
      if @exam.save
        format.html { redirect_to exam_url(@exam), notice: "Exam was successfully created." }
        format.json { render :show, status: :created, location: @exam }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exams/1 or /exams/1.json
  def update
    authorize @exam

    respond_to do |format|
      if @exam.update(exam_params)
        format.html { redirect_to exam_url(@exam), notice: "Exam was successfully updated." }
        format.json { render :show, status: :ok, location: @exam }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exam.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1 or /exams/1.json
  def destroy
    authorize @exam
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to exams_url, notice: "Exam was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exam
      @exam = Exam.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exam_params
      params
        .require(:exam)
        .permit(:exam_type,
                :subject_id,
                :user_id,
                :schedule,
                :name,
                :attachment,
                :institution_id,
               )
    end
end
