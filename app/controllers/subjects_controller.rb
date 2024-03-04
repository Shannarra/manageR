class SubjectsController < ApplicationController
  before_action :set_subject, only: %i[ show edit update destroy ]

  def possible_subjects
    IClass.includes(:subjects).find(params[:class_id]).subjects
  end
  
  # GET /subjects or /subjects.json
  def index
    @subjects = possible_subjects
  end

  # GET /subjects/1 or /subjects/1.json
  def show
  end

  # GET /subjects/new
  def new
    authorize current_user
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
    authorize current_user
  end

  # POST /subjects or /subjects.json
  def create
    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to subject_url(@subject), notice: "Subject was successfully created." }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1 or /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to subject_url(@subject), notice: "Subject was successfully updated." }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1 or /subjects/1.json
  def destroy
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url, notice: "Subject was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # TL;DR; on why is this done this way:
    # We are forcing the check for the institution, class AND subject IDs to be valid and
    # match according to the current subject we are trying to reach. This will yield larger
    # and larger benefits the more institutions and subjects there are, checking for validity
    # without something along the lines of multi-tenancy.
    def set_subject
      current_institution = Institution.includes(:i_classes).find(params[:institution_id])
      klass = current_institution.i_classes.find(params[:class_id])
      subject_id = params[:subject_id]
      @subject = possible_subjects.find(subject_id)
    rescue ActiveRecord::RecordNotFound
      message = "Class not found for the current institution"
      message = "Subject does not exist for the class \"#{klass.name}\"." if klass
      url = klass.nil? ? root_url : class_url
      
      respond_to do |format|
        format.html { redirect_to url, alert: message }
      end
    end

    # Only allow a list of trusted parameters through.
    def subject_params
      params.require(:subject).permit(:name, :year, :description, :teacher_id, :klass_id)
    end
end
