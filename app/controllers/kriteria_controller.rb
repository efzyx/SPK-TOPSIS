class KriteriaController < ApplicationController
  before_action :set_kriterium, only: [:show, :edit, :update, :destroy]
  before_action :cekData, only: [:index, :edit]

  def index
    @kriteria = Kriterium.all
  end

  def new
    @kriterium = Kriterium.new
  end


  def edit
  end

  def create
    @kriterium = Kriterium.new(kriterium_params)

    respond_to do |format|
      if @kriterium.save
        format.html { redirect_to new_kriterium_path, notice: 'Kriterium was successfully created.' }
        format.json { render :show, status: :created, location: @kriterium }
      else
        format.html { render :new }
        format.json { render json: @kriterium.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @kriterium.update(kriterium_params)
        format.html { redirect_to edit_kriterium_path, notice: 'Kriterium was successfully updated.' }
        format.json { render :show, status: :ok, location: @kriterium }
      else
        format.html { render :edit }
        format.json { render json: @kriterium.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @kriterium.destroy
    respond_to do |format|
      format.html { redirect_to kriteria_url, notice: 'Kriterium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kriterium
      @kriterium = Kriterium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kriterium_params
      params.require(:kriterium).permit(:nama, :tipe, :bobot)
    end

    def cekData
      begin
        if Kriterium.first == nil
          redirect_to error_path
        end
      rescue
        redirect_to error_path
      end
    end

    def disableCRUD
      redirect_to kriteria_url, notice: 'Read only mode, mohon maaf :D'
    end
end
