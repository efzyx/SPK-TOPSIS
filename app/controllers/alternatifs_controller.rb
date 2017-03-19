class AlternatifsController < ApplicationController
  before_action :set_alternatif, only: [:show, :edit, :update, :destroy]
  before_action :cekData, only: [:index, :edit]
  def index
    @alternatifs = Alternatif.all
  end

  def new
    @alternatif = Alternatif.new
  end


  def edit
  end

  def create
    @alternatif = Alternatif.new(alternatif_params)

    respond_to do |format|
      if @alternatif.save
        format.html { redirect_to new_alternatif_path, notice: 'Alternatif was successfully created.' }
        format.json { render :show, status: :created, location: @alternatif }
      else
        format.html { render :new }
        format.json { render json: @alternatif.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @alternatif.update(alternatif_params)
        format.html { redirect_to edit_alternatif_path, notice: 'Alternatif was successfully updated.' }
        format.json { render :show, status: :ok, location: @alternatif }
      else
        format.html { render :edit }
        format.json { render json: @alternatif.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @alternatif.destroy
    respond_to do |format|
      format.html { redirect_to alternatifs_url, notice: 'Alternatif was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alternatif
      @alternatif = Alternatif.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alternatif_params
      params.require(:alternatif).permit(:nama_alternatif)
    end
    
    def cekData
      begin 
        if Alternatif.first == nil
          redirect_to error_path
        end
      rescue
        redirect_to error_path
      end
    end
end
