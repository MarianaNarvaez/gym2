class DropHasCategoriestable < ActiveRecord::Migration[5.1]
  def change
  	drop_table :has_categories
  end
end
