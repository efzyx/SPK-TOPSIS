class WelcomeController < ApplicationController
  require 'matrix'
  before_action :cekData

  def error
  end

  def tables

    @alternatif = getAllAlternatifs
    @kriteria = getAllKriterias
    @rangking = getAllRangkings



    @rangeAlternatif = countRangeAlternatif
    @rangeKriteria = countRangeKriteria
    @X = getX
    @R = getR
    @Y = getY
    @APlus = getAPlus
    @AMinus = getAMinus
  end

  def diagram
    @rangeKriteria = countRangeKriteria
    @rangking = getAllRangkings
    @alternatif = getAllAlternatifs
    @rangeAlternatif = countRangeAlternatif
    @DPlus = getDPlus
    @DMinus = getDMinus
    @V = getV
    @data = getResult
  end


  private

    def cekData
      if Alternatif.first == nil or Kriterium.first == nil or Rangking.first == nil then
          redirect_to error_path
      end
    end
    def getRangkingByKriteriaId(id)
      return Rangking.where(kriteria_id: id)
    end

    def getAllKriterias
      return Kriterium.all
    end

    def getAllRangkings
      return Rangking.all
    end

    def getAllAlternatifs
      return Alternatif.all
    end

    def getX
      @Xtemp=[]
      i=0
      @kriteria = getAllKriterias
      @kriteria.each do |k|
        x=0
        @rang = getRangkingByKriteriaId(k.id)
          @rang.each do |r|
            x=x+(r.nilai.to_f ** 2)
          end
        @Xtemp[i] = Math.sqrt(x)
        i+=1
      end
      return @Xtemp
    end

    def getR
      @Rtemp=[]
      n=0
      @kriteria = getAllKriterias
      @kriteria.each do |k|
        @r=[]
        i=0
        @rang = getRangkingByKriteriaId(k.id)
        @rang.each do |r|
          @r[i] = r.nilai.to_f / getX[n]
          i+=1
        end
        @Rtemp[n] = @r
        n+=1
      end
      return @Rtemp
    end

    def getMatrixR
      @matrix = Matrix[]
      n=0
      @X = getX
      @kriteria = getAllKriterias
      @kriteria.each do |k|
        @r=[]
        i=0
        @rang = getRangkingByKriteriaId(k.id)
        @rang.each do |r|
          @r[i] = r.nilai.to_f / @R[n]
          i+=1
        end
        @matrix = Matrix.rows(@matrix.to_a << @r)
        n+=1
      end
      return @matrix
    end

    def getY
      @Ytemp=[]
      @X = getX
      n=0
      @kriteria = getAllKriterias
      @kriteria.each do |k|
        @r=[]
        i=0
        @rang = getRangkingByKriteriaId(k.id)
        @rang.each do |r|
          @r[i] = (r.nilai.to_f / @X[n])*k.bobot.to_f
          i+=1
        end
        @Ytemp[n] = @r
        n+=1
      end
      return @Ytemp
    end

    def getAPlus
      j=0
      @AP = []
      @kr = getAllKriterias.first;
      @Y = getY
      @Y.each do |subY|
          @A=nil
          subY.each do |y|
            case @kr.tipe
            when 0
              begin
                if y < @A
                  @A=y
                end
              rescue
                @A=y
              end
            when 1
              begin
                if y > @A
                  @A=y
                end
              rescue
                @A=y
              end
            end
          end
          @AP[j]=@A
          j+=1
          @kr = @kr.next
      end
      return @AP
    end

    def getAMinus
      j=0
      @AP = []
      @kr = getAllKriterias.first;
      getY.each do |subY|
          @A=nil
          subY.each do |y|
            case @kr.tipe
            when 0
              begin
                if y > @A
                  @A=y
                end
              rescue
                @A=y
              end
            when 1
              begin
                if y < @A
                  @A=y
                end
              rescue
                @A=y
              end
            end
          end
          @AP[j]=@A
        j+=1
        @kr = @kr.next
      end
      return @AP
    end


    def getDPlus
      i=0
      @AP = getAPlus
      @DP=[]
      @Y = getY
      countRangeAlternatif.each do |a|
        @D=0
        j=0
        countRangeKriteria.each do |k|
          begin
            @D += (@Y[j][i]-@AP[j]) ** 2
            j+=1
          rescue
            @D += 0
            j+=1
          end

        end
        @DP[i]= Math.sqrt(@D)
        i+=1
      end
      return @DP
    end

    def getDMinus
      i=0
      @AM = getAMinus
      @DP=[]
      @Y = getY
      countRangeAlternatif.each do |a|
        @D=0
        j=0
        countRangeKriteria.each do |k|
          begin
            @D += (@AM[j]-@Y[j][i]) ** 2
            j+=1
          rescue
            @D += 0
            j+=1
          end

        end
        @DP[i]= Math.sqrt(@D)
        i+=1
      end
      return @DP
    end

    def getV
      @V =[]
      @DM = getDMinus
      @DP = getDPlus
      i=0
      countRangeAlternatif.each do |a|
        @V[i] = @DM[i]/(@DM[i]+@DP[i])
        i+=1
      end
      return @V
    end

    def getDebugD
      i=0
      @DP=[]
      getAllAlternatifs.each do |a|
        @D=[]
        j=0
        getAllKriterias.each do |k|
            @D[j]= (getY[j][i]-getAPlus[j]) ** 2
            j+=1
        end
        @DP[i]= @D
        i+=1
      end
      return @DP
    end

    def countRangeAlternatif
      return (0..getAllAlternatifs.size-1)
    end

    def countRangeKriteria
      return (0..getAllKriterias.size-1)
    end

    def getResult
      @data = []
      @V = getV
      i=0
      @alternatif = getAllAlternatifs

      @alternatif.each do |al|
        @data[i] = Hasil.new(al.nama_alternatif, @V[i])
        i+=1
      end

      return @data
    end
  end

  class Hasil
    def initialize(n , v)
      @nama=n
      @v = v
    end

    def getNama
      return @nama
    end

    def getVR
      return @v
    end

end
