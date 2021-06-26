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
    Category.create(
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
end

puts "It has been seeded."