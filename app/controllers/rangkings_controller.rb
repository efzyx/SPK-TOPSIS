class RangkingsController < ApplicationController
 before_action :set_rangking, only: [:show, :edit, :update, :destroy]


 def index
   @rangkings = Rangking.all
 end



 def new
   @rangking = Rangking.new
 end

 def edit
 end

 def create
   @rangking = Rangking.new(rangking_params)

   respond_to do |format|
     if @rangking.save
       format.html { redirect_to new_rangking_path, notice: 'Rangking was successfully created.' }
       format.json { render :show, status: :created, location: @rangking }
     else
       format.html { render :new }
       format.json { render json: @rangking.errors, status: :unprocessable_entity }
     end
   end
 end

 def update
   respond_to do |format|
     if @rangking.update(rangking_params)
       format.html { redirect_to edit_rangking_path, notice: 'Rangking was successfully updated.' }
       format.json { render :show, status: :ok, location: @rangking }
     else
       format.html { render :edit }
       format.json { render json: @rangking.errors, status: :unprocessable_entity }
     end
   end
 end

 def destroy
   @rangking.destroy
   respond_to do |format|
     format.html { redirect_to rangkings_url, notice: 'Rangking was successfully destroyed.' }
     format.json { head :no_content }
   end
 end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_rangking
     @rangking = Rangking.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def rangking_params
     params.require(:rangking).permit(:alternatif_id, :kriteria_id, :nilai)
   end
end
