class SpeciesController < ApplicationController
  before_action :authenticate_veterinarian!

  def new
    @species = Species.new
  end

  def create
    @species = Species.new(species_params)
    if @species.save
      redirect_to dictionaries_path(tab: 'species'), notice: 'Gatunek został pomyślnie dodany.'
    else
      render :new
    end
  end

  def edit
    @species = Species.find(params[:id])
  end

  def update
    @species = Species.find(params[:id])
    if @species.update(species_params)
      redirect_to dictionaries_path(tab: 'species'), notice: 'Gatunek został pomyślnie edytowany.'
    else
      render :edit
    end
  end

  private

  def species_params
    params.require(:species).permit(:name, :status)
  end
end
