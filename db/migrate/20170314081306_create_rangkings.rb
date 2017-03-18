class CreateRangkings < ActiveRecord::Migration[5.0]
  def change
    create_table :rangkings do |t|
      t.references :alternatif, foreign_key: true
      t.references :kriteria, foreign_key: true
      t.float :nilai

      t.timestamps
    end
  end
end
