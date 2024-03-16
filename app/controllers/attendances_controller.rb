class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy]

  # GET /attendances or /attendances.json
  def index
    @attendances = Attendance.for_institution(current_user.institution).per_class
    #authorize @attendances
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new

    authorize @attendance
  end

  def multi
    authorize current_user
    @attendance = Attendance.new
  end

  def continue_multi
    if Attendance.partial.count.zero?
      redirect_to multi_attendances_url,
                  alert: "No class attendance to continue, you can always create one here: #{multi_attendances_url}." and return
    end

    authorize current_user
    @attendance = Attendance.where(partial: true).last

    already_taken = Attendance.daily.where(i_class_id: @attendance.i_class, partial: false).count

    unless already_taken.zero?
      @attendance.delete
      redirect_to attendances_url, notice: "Class attendance for this class has already been taken for today"
    end
  end

  def start_multi
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to continue_multi_attendances_url(@attendance), notice: "Attendance was successfully created." }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :multi, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  def save_multi
    attendance = Attendance.where(partial: true).last

    items = params.fetch(:attendance, [])
    students = params.fetch(:students, [])

    objects = []
    students.zip(items) do  |item|
      objects << {
        i_class_id: attendance.i_class_id,
        teacher_id: attendance.teacher_id,
        student_id: item[0],
        attendance_type: item[1]
      }
    end

    unless objects.all? {|o| Attendance.new(o).valid? }
      # TODO: This is a great place to add something along the lines of
      # DataDog/NewRelic/Sentry and log an error to administrators/tech support

      render continue_multi_attendances_url,
             status: :unprocessable_entity,
             alert: 'Something went wrong, please try submitting the multi attendance again.'
    end

    Attendance.insert_all!(objects)

    respond_to do |format|
      if attendance.delete
        format.html {
          redirect_to attendances_url(@attendance),
                      # rubocop:disable Layout/LineLength
                      notice: "Attendances for class #{attendance.i_class.name} successfully saved. #{students.length} #{"record".pluralize(students)} successfully updated."
          # rubocop:enable Layout/LineLength
        }
      else
        format.html { render continue_multi_attendances_url, status: :unprocessable_entity }
      end
    end
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if Attendance.exists?(*@attendance.id)
        format.html { redirect_to attendances_url, notice: "This attendance has already been taken." }
      elsif @attendance.save
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    # rescue NoMethodError
    #   @attendance.errors.add(:attendance_type, "must exist")
    #   format.html { render :new, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully updated." }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url, notice: "Attendance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      params.require(:attendance).permit(:attendance_type, :teacher_id, :student_id, :i_class_id, :partial)
    end
end
