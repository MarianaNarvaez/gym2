class AddCompartidoToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :compartido, :string
  end
end
