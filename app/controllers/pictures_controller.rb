class PicturesController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :authenticate_user!, only: [ :index, :show ]
  before_action :authenticate_veterinarian!, only: [ :new, :create, :edit, :update ]

  expose(:user) { User.find(params[:user_id]) }
  expose(:picture, attributes: :picture_params)
  expose(:pictures) { user.pictures.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 8) }

  def index
    if params[:search]
      self.pictures = Picture.search(params[:search], params[:user_id]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 8)
    end
  end

  def show
  end

  def new
    @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
  end

  def create
    if picture.save
      redirect_to user_pictures_path(user), notice: 'Zdjęcie zostało pomyślnie utworzone.'
    else
      @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
      render :new
    end
  end

  def edit
    @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
  end

  def update
    if picture.save
      redirect_to user_pictures_path(user), notice: 'Zdjęcie zostało pomyślnie edytowane.'
    else
      @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
      render :edit
    end
  end

  private

    def picture_params
      params.require(:picture).permit(:name, :description, :user_id, :image, :animal_id)
    end

    def sort_column
      Picture.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
