class IClassesController < ApplicationController
  before_action :set_i_class, only: %i[show edit update delete]

  # GET /i_classes or /i_classes.json
  def index
    @i_classes = possible_classes
  end

  def possible_classes
    Institution
      .includes(:i_classes)
      .find_by_name(current_institution_name)
      .i_classes
  end

  def current_institution_name
    params[:institution_name] || current_user.institution.name
  end

  def manage
    authorize current_user

    name = params[:search] || ""

    @klasses = IClass
                 .where(institution: current_user.institution)
                 .where('name ilike ?', "%#{name}%")
                 .order(name: :asc)
                 .page(params[:page])
                 .per(params[:per_page] || DEFAULT_PER_PAGE)
  end

  # GET /i_classes/1 or /i_classes/1.json
  def show
  end

  # GET /i_classes/new
  def new
    @i_class = IClass.new
  end

  # GET /i_classes/1/edit
  def edit
    authorize @i_class
  end

  # POST /i_classes or /i_classes.json
  def create
    @i_class = IClass.new(i_class_params)

    respond_to do |format|
      if @i_class.save
        format.html { redirect_to institution_url, notice: "Class was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /i_classes/1 or /i_classes/1.json
  def update
    respond_to do |format|
      if @i_class.update(i_class_params)
        format.html { redirect_to class_url(class_name: @i_class.name), notice: "I class was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /i_classes/1 or /i_classes/1.json
  def destroy
    @i_class.destroy

    respond_to do |format|
      format.html { redirect_to i_classes_url, notice: "I class was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_i_class
      institution = Institution.find_by_name(params[:institution_name])
      klass = params[:class_name]
      @i_class = possible_classes.find_by_name(klass)
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to institution_url, alert: "Class does not exist for your institution." }
      end
    end

    # Only allow a list of trusted parameters through.
    def i_class_params
      params.require(:i_class).permit(:name, :year, :description, :institution_name, :institution_id)
    end
end
