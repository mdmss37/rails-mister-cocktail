require 'open-uri'
require 'json'

class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
    # @doses_ingredients = @cocktail.doses.select("doses.*, ingredients.*").joins(:ingredient)
    #doses#.select("ingredients.name, doses.description").joins(:doses, :ingredients)
    url = "http://www.thecocktaildb.com/api/json/v1/1/search.php?s=#{@cocktail.name}"
    data = JSON.parse(open(url).read)["drinks"][0]
    @thumbnail = data["strDrinkThumb"]
    @instructions = data["strInstructions"]
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end

end
