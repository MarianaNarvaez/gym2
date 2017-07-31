class RemoveUsuarioToImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :usuario, :string
  end
end
