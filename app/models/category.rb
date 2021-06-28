class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', 
                      optional: true, 
                      foreign_key: :category_id
                      
  has_many :children, class_name: 'Category', 
                      dependent: :destroy

  def self.search(search)
    if search
      category = Category.find_by(name: search)
      if category
        self.where(id: category)
      else
        Category.all
      end
    else
      Category.all
    end
  end
end
