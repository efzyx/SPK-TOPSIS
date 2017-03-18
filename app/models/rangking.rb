class Rangking < ApplicationRecord
  belongs_to :alternatif
  belongs_to :kriteria, class_name: "Kriterium"

end
