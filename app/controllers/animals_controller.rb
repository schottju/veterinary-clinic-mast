class AnimalsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :authenticate_user!, only: [ :index, :show ]
  before_action :authenticate_veterinarian!, only: [ :new, :create, :edit, :update ]

  expose(:user) { User.find(params[:user_id]) }
  expose(:animal, attributes: :animal_params)
  expose(:animals) { user.animals.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 8) }

  def index
    if params[:search]
      self.animals = Animal.search(params[:search], params[:user_id]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 8)
    end
  end

  def show
    @pictures = animal.pictures.order(:created_at).paginate(page: params[:pictures_page], per_page: 10)
    @medical_records = animal.medical_records.order(:created_at).paginate(page: params[:medical_records_page], per_page: 10)
  end

  def new
    @species = Species.order(:name).where(status: "odblokowany")
  end

  def create
    animal.weight = change_comma_to_period(params[:animal][:weight])
    animal.age = change_comma_to_period(params[:animal][:age])
    if animal.save
      redirect_to user_animals_path(user), notice: 'Zwierzę zostało pomyślnie utworzone.'
    else
      @species = Species.order(:name).where(status: "odblokowany")
      render :new
    end
  end

  def edit
    @species = Species.order(:name).map { |s| [ "#{s.name} #{"(zablokowane)" if s.zablokowany?}", s.id ] }
  end

  def update
    animal.weight = change_comma_to_period(params[:animal][:weight])
    animal.age = change_comma_to_period(params[:animal][:age])
    if animal.save
      redirect_to user_animals_path(user), notice: 'Zwierzę zostało pomyślnie edytowane.'
    else
      @species = Species.order(:name).map { |s| [ "#{s.name} #{"(zablokowane)" if s.zablokowany?}", s.id ] }
      render :edit
    end
  end

  private

    def animal_params
      params.require(:animal).permit(:id_number, :name, :birth_date, :amount,
                                     :weight, :gender, :age, :description,
                                     :user_id, :species_id)
    end

    def sort_column
      Animal.column_names.include?(params[:sort]) ? params[:sort] : "id_number"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
