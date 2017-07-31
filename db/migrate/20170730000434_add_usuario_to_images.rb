class AddUsuarioToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :usuario, :string
  end
end
