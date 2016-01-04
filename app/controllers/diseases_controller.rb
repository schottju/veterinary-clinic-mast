class DiseasesController < ApplicationController
  before_action :authenticate_veterinarian!

  expose(:disease, attributes: :disease_params)

  def new
  end

  def create
    if disease.save
      redirect_to dictionaries_path(tab: 'diseases'), notice: 'Choroba została pomyślnie dodana.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if disease.save
      redirect_to dictionaries_path(tab: 'diseases'), notice: 'Choroba została pomyślnie edytowana.'
    else
      render :edit
    end
  end

  private

  def disease_params
    params.require(:disease).permit(:name, :status)
  end
end
