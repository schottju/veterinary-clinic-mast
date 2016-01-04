class MedicalRecordsController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :authenticate_user!, only: [ :index, :show ]
  before_action :authenticate_veterinarian!, only: [ :new, :create, :edit, :update ]

  expose(:medical_record, attributes: :medical_record_params)
  expose(:user) { User.find(params[:user_id]) }
  expose(:medical_records) { user.medical_records.order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 8) }

  def index
    if params[:search]
      self.medical_records = MedicalRecord.search(params[:search], params[:user_id]).order(sort_column + " " + sort_direction).paginate(page: params[:page], per_page: 8)
    end
  end

  def show
  end

  def new
    @units = Unit.order(:name).where(status: "odblokowany")
    @diseases = Disease.order(:name).where(status: "odblokowany")
    @treatments = Treatment.order(:name).where(status: "odblokowany")
    @pictures = Picture.where(user_id: user.id).map { |picture| [ "Nazwa: #{picture.name}, opis: #{picture.description}", picture.id  ] }
    @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
  end

  def create
    medical_record.additional_cost = change_comma_to_period(params[:medical_record][:additional_cost])

    params[:medical_record][:medicines_attributes].values.each_with_index do |medicine, i|
      medical_record.medicines[i].price = change_comma_to_period(medicine[:price])
      medical_record.medicines[i].amount = change_comma_to_period(medicine[:amount])
    end if params[:medical_record] and params[:medical_record][:medicines_attributes]

    if medical_record.save
      redirect_to user_medical_record_path(user, medical_record), notice: 'Nowy wpis w kartotece został utworzony.'
    else
      @units = Unit.order(:name).where(status: "odblokowany")
      @diseases = Disease.order(:name).where(status: "odblokowany")
      @treatments = Treatment.order(:name).where(status: "odblokowany")
      @pictures = Picture.where(user_id: user.id).map { |picture| [ "Nazwa: #{picture.name}, opis: #{picture.description}", picture.id  ] }
      @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
      render :new
    end
  end

  def edit
    @units = Unit.order(:name).map { |unit| [ "#{unit.name} #{"(zablokowane)" if unit.zablokowany?}", unit.id ] }
    @diseases = Disease.order(:name).map { |disease| [ "#{disease.name} #{"(zablokowane)" if disease.zablokowany?}", disease.id ] }
    @treatments = Treatment.order(:name).map { |treatment| [ "#{treatment.name} #{"(zablokowane)" if treatment.zablokowany?}", treatment.id ] }
    @pictures = Picture.where(user_id: user.id).map { |picture| [ "Nazwa: #{picture.name}, opis: #{picture.description}", picture.id  ] }
    @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
  end

  def update
    medical_record.additional_cost = change_comma_to_period(params[:medical_record][:additional_cost])

    params[:medical_record][:medicines_attributes].values.each_with_index do |medicine, i|
      medical_record.medicines[i].price = change_comma_to_period(medicine[:price])
      medical_record.medicines[i].amount = change_comma_to_period(medicine[:amount])
    end if params[:medical_record] and params[:medical_record][:medicines_attributes]

    if medical_record.save
      redirect_to user_medical_record_path(user, medical_record), notice: 'Wpis w kartotece został edytowany.'
    else
      @units = Unit.order(:name).map { |unit| [ "#{unit.name} #{"(zablokowane)" if unit.zablokowany?}", unit.id ] }
      @diseases = Disease.order(:name).map { |disease| [ "#{disease.name} #{"(zablokowane)" if disease.zablokowany?}", disease.id ] }
      @treatments = Treatment.order(:name).map { |treatment| [ "#{treatment.name} #{"(zablokowane)" if treatment.zablokowany?}", treatment.id ] }
      @pictures = Picture.where(user_id: user.id).map { |picture| [ "Nazwa: #{picture.name}, opis: #{picture.description}", picture.id  ] }
      @animals = Animal.where(user_id: user.id).map { |animal| [ "ID: #{animal.id_number}, nazwa: #{animal.name}, ilość: #{animal.amount}, wiek: #{animal.age}, waga: #{animal.weight}, data urodzenia: #{animal.birth_date}, gatunek: #{animal.try(:species).try(:name)}, opis: #{animal.description}", animal.id ] }
      render :edit
    end
  end

  private

    def medical_record_params
      params.require(:medical_record).permit(
          :anamnesis, :description, :comment, :user_id, :veterinarian_id, :additional_cost, :total_cost,
          treatment_ids: [], picture_ids: [], disease_ids: [], animal_ids: [],
          medicines_attributes: [ :id, :name, :description, :amount, :grace_period, :price, :serial_number, :dosage, :unit_id, :_destroy ]
      )
    end

    def sort_column
      MedicalRecord.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
