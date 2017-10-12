class DosesController < ApplicationController

  def new
    # @cocktail = Cocktail.find(params[:cocktail_id])
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @ingredients = Ingredient.all
    # @dose.cocktail = @cocktail
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = @cocktail.doses.build(dose_params)
    # @dose.description = params[:dose][:description]
    # @ingredient = Ingredient.find(params[:dose][:ingredient_id])
    
    # @dose.ingredient = @ingredient
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail
    @dose.destroy
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
