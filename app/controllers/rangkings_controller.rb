class RangkingsController < ApplicationController
 before_action :set_rangking, only: [:show, :edit, :update, :destroy]

 @currentAlt = nil
 @currentKri = nil

 def index
   @rangkings = Rangking.all
 end



 def new
   @rangking = Rangking.new
   @allRangkings = Rangking.all
   @allAlternatifs = Alternatif.all
   @allKriterias = Kriterium.all
   @found = false
   @allAlternatifs.each do |a|
     if @allRangkings.exists?(alternatif_id: a.id) == true
     @allKriterias.each do |k|
       if @allRangkings.exists?(alternatif_id: a.id, kriteria_id: k.id) == false
         @found = true
         @currentAlt = a.id
         @currentKri = k.id
         break if @found == true
       end
     end
     else
       @found = true
       @currentAlt = a.id
       @currentKri = @allKriterias.first.id
     end
     break if @found == true
   end
 end

 def edit
   currentR = Rangking.find(params[:id])
   @currentAlt = currentR.alternatif_id
   @currentKri = currentR.kriteria_id
 end

 def create
   @rangking = Rangking.new(rangking_params)
   respond_to do |format|
     if @rangking.save
       format.html { redirect_to new_rangking_path, notice: 'Perangkingan berhasil disimpan, silahkan lengkapi rangking selanjutnya' }
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
