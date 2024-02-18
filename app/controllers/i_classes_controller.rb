class IClassesController < ApplicationController
  before_action :set_i_class, only: %i[ show edit update destroy ]

  # GET /i_classes or /i_classes.json
  def index
    institution = params[:institution_id] || current_user.institution.id
    @i_classes = IClass.for(institution)
    authorize @i_classes
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
  end

  # POST /i_classes or /i_classes.json
  def create
    @i_class = IClass.new(i_class_params)

    respond_to do |format|
      if @i_class.save
        format.html { redirect_to class_url(id: @i_class), notice: "I class was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /i_classes/1 or /i_classes/1.json
  def update
    respond_to do |format|
      if @i_class.update(i_class_params)
        format.html { redirect_to class_url(id: @i_class), notice: "I class was successfully updated." }
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
      @i_class = IClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def i_class_params
      params.require(:i_class).permit(:name, :year, :institution_id)
    end
end
