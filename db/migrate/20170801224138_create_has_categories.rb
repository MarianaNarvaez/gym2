class CreateHasCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :has_categories do |t|
      t.references :image, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
