class ChangeTypeCompartido < ActiveRecord::Migration[5.1]
  def change
  	remove_column :images, :compartido
  end
end
