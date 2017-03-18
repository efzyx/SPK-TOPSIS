class CreateKriteria < ActiveRecord::Migration[5.0]
  def change
    create_table :kriteria do |t|
      t.string :nama
      t.integer :tipe
      t.float :bobot

      t.timestamps
    end
  end
end
