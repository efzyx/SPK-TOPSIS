class CreateAlternatifs < ActiveRecord::Migration[5.0]
  def change
    create_table :alternatifs do |t|
      t.string :nama_alternatif

      t.timestamps
    end
  end
end
