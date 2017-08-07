class Addcompartido < ActiveRecord::Migration[5.1]
  def change
  	add_column :images, :compartido, :integer
  end
end
