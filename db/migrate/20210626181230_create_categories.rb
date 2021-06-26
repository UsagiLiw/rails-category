class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.integer :catId
      t.string :name
      t.string :label
      t.boolean :isLeaf
      t.integer :firstLevelCatId
      t.boolean :variationCat
      t.boolean :active
      
      t.references :parent_category, foreign_key: { to_table: :categories}

      t.timestamps
    end
  end
end
