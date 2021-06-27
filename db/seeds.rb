# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'net/http'
require 'json'

Category.destroy_all

url = 'https://s3-ap-southeast-1.amazonaws.com/kiyo-development/test/categories.json'
uri = URI(url)
response = Net::HTTP.get(uri)
all_categories = JSON.parse(response) 

all_categories.each do |category|
    root = Category.create(
        {
            catId: category["id"],
            name: category["name"],
            label: category["label"],
            isLeaf: category["isLeaf"],
            firstLevelCatId: category["firstLevelCatId"],
            variationCat: category["variationCat"],
            active: category["active"],
        }
    )
    category["subcategories"]&.each do |subcategory|
        level_2 = root.children.create(
            {
                catId: subcategory["id"],
                name: subcategory["name"],
                label: subcategory["label"],
                isLeaf: subcategory["isLeaf"],
                firstLevelCatId: subcategory["firstLevelCatId"],
                variationCat: subcategory["variationCat"],
                active: subcategory["active"],
            }
        )

        subcategory["subcategories"]&.each do |sub2category|
            level_3 = level_2.children.create(
                {
                    catId: sub2category["id"],
                    name: sub2category["name"],
                    label: sub2category["label"],
                    isLeaf: sub2category["isLeaf"],
                    firstLevelCatId: sub2category["firstLevelCatId"],
                    variationCat: sub2category["variationCat"],
                    active: sub2category["active"],
                }
            )
            sub2category["subcategories"]&.each do |sub3category|
                level_4 = level_3.children.create(
                    {
                        catId: sub3category["id"],
                        name: sub3category["name"],
                        label: sub3category["label"],
                        isLeaf: sub3category["isLeaf"],
                        firstLevelCatId: sub3category["firstLevelCatId"],
                        variationCat: sub3category["variationCat"],
                        active: sub3category["active"],
                    }
                )
                sub3category["subcategories"]&.each do |sub4category|
                    level_5 = level_4.children.create(
                        {
                            catId: sub4category["id"],
                            name: sub4category["name"],
                            label: sub4category["label"],
                            isLeaf: sub4category["isLeaf"],
                            firstLevelCatId: sub4category["firstLevelCatId"],
                            variationCat: sub4category["variationCat"],
                            active: sub4category["active"],
                        }
                    )
                    sub4category["subcategories"]&.each do |sub5category|
                        level_5.children.create(
                            {
                                catId: sub5category["id"],
                                name: sub5category["name"],
                                label: sub5category["label"],
                                isLeaf: sub5category["isLeaf"],
                                firstLevelCatId: sub5category["firstLevelCatId"],
                                variationCat: sub5category["variationCat"],
                                active: sub5category["active"],
                            }
                        )
                    end
                end
            end
        end
    end
end

puts "It has been seeded."