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

50.times do
  url = "http://www.thecocktaildb.com/api/json/v1/1/random.php"
  data = JSON.parse(open(url).read)
  drink = data["drinks"][0]
  # p "Drink name is", drink["strDrink"] == []
  p "cocktail?", Cocktail.where("name = ? ", drink["strDrink"]).empty?
  if Cocktail.where("name = ? ", drink["strDrink"]).empty?
    thumbnail_url = drink["strDrinkThumb"]
    instruction = drink["strInstructions"]
    cocktail = Cocktail.new(name: drink["strDrink"])
    cocktail.remote_photo_url = thumbnail_url
    cocktail.instruction = instruction
    cocktail.save
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
    p "ingredient is", ingredient if ingredient

    cocktail && ingredient && Dose.create(description: drink["strMeasure#{num}"], cocktail: cocktail, ingredient: ingredient)
  end
end

