# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require "json"

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

10.times do
  url = "http://www.thecocktaildb.com/api/json/v1/1/random.php"
  data = JSON.parse(open(url).read)
  drink = data["drinks"][0]
  p "Drink name is", drink["strDrink"] == []
  p "cocktail?", Cocktail.where("name = ? ", drink["strDrink"]).empty?
  if Cocktail.where("name = ? ", drink["strDrink"]).empty?
    cocktail = Cocktail.create!(name: drink["strDrink"])
  else
    drink_name = drink["strDrink"]
    cocktail = Cocktail.where("name = ?", drink_name)[0]
  end

  p "cocktail is", cocktail

  (1..15).to_a.each do |num|
    # p "ingredient is:", drink["strIngredient#{num}"]
    if Ingredient.where("name= ? ", drink["strIngredient#{num}"]).empty? && drink["strIngredient#{num}"] != "" && drink["strIngredient#{num}"] != nil
      ingredient = Ingredient.create!(name: drink["strIngredient#{num}"])
    else
      ingredient = Ingredient.where("name= ? ", drink["strIngredient#{num}"])[0]
    end
    p "ingredient is", ingredient

    cocktail && ingredient && Dose.create!(description: drink["strMeasure#{num}"], cocktail: cocktail, ingredient: ingredient)
    # dose && dose.cocktail = cocktail
    # dose && dose.ingredient = ingredient
    # puts dose
    # dose && dose.valid? && dose.save! 
  end
  
  # puts cocktail
end
















# url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
# data = open(url).read
# data = JSON.parse(data)

# puts data["drinks"]
# puts "seed ingredients"

# data["drinks"].each do |drink|
#   puts drink["strIngredient1"]
#   Ingredient.create!(name: drink["strIngredient1"])
# end

# puts "finish ingredients"



# puts "seed drinks"

# Ingredient.all.each do |ingredient|
#   url = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?i=#{ingredient.name}"
#   puts url
#   data = JSON.parse(open(url).read)
#   puts data
#   data["drinks"].each do |drink|
#     puts drink["strDrink"]
#     Cocktail.create!(name: drink["strDrink"])
#   end
# end

# puts "finish drinks"

