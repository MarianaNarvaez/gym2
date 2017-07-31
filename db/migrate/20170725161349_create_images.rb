class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :nombre
      t.string :ubicacion
      t.string :fecha
      t.string :autor
      t.string :peso

      t.timestamps
    end
  end
end
