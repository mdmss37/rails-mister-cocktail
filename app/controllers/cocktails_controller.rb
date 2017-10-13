require 'open-uri'
require 'json'

class CocktailsController < ApplicationController
  def index
    # https://stackoverflow.com/questions/2752231/random-record-in-activerecord
    @cocktails = Cocktail.order("RANDOM()").limit(9)
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @doses = @cocktail.doses
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      flash[:notice] = "Cocktail #{@cocktail.name} has been created"
      redirect_to cocktail_path(@cocktail)
    else
      flash[:alert] = "Something is wrong"
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :photo_cache)
  end

end
