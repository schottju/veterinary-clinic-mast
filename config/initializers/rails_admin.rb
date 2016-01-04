module ActiveRecord
  module RailsAdminEnum
    def enum(definitions)
      super

      definitions.each do |name, values|
        define_method("#{ name }_enum") { self.class.send(name.to_s.pluralize).to_a }

        define_method("#{ name }=") do |value|
          if value.kind_of?(String) and value.to_i.to_s == value
            super value.to_i
          else
            super value
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send(:extend, ActiveRecord::RailsAdminEnum)


RailsAdmin.config do |config|

  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  config.current_user_method(&:current_user)

  config.authorize_with do
    (redirect_to main_app.authenticated_root_path, notice: "Pas de droits d'administrateur.") unless current_user.admin?
  end

  config.default_items_per_page = 8

  config.actions do
    dashboard
    index
    new
    export
    bulk_delete
    show
    edit
    delete
  end

  config.model 'Address' do
    configure :user do
      label "Utilsateur"
    end

    object_label_method do
      :custom_label_method
    end

    nested do
      configure :user do
        hide
      end
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :street
      field :house_number
      field :flat_number
      field :zip_code
      field :city
      field :borough
      field :district
      field :province
      field :country
      field :user do
        filterable false
        searchable false
      end
      field :created_at
      field :updated_at
    end

    edit do
      field :street
      field :house_number
      field :flat_number
      field :zip_code
      field :city
      field :borough
      field :district
      field :province
      field :country do
        help 'Optionnel. (Entrez abréviation du pays)'
      end
      field :user do
        inline_add false
        inline_edit false
      end
    end

    show do
      field :id
      field :street
      field :house_number
      field :flat_number
      field :zip_code
      field :city
      field :borough
      field :district
      field :province
      field :country
      field :user
      field :created_at
      field :updated_at
    end

    export do
      field :id
      field :street
      field :house_number
      field :flat_number
      field :zip_code
      field :city
      field :borough
      field :district
      field :province
      field :country
      field :created_at
      field :updated_at
      field :user
    end
  end

  config.model 'User' do
    configure :address do
      label "Adresse"
    end

    configure :veterinarian do
      label "Vétérinaire"
    end

    configure :password do
      label "Mot de passe"
    end

    configure :password_confirmation do
      label "confirmation mot de passe"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :first_name
      field :last_name
      field :pesel
      field :phone_number
      field :email
      field :address do
        filterable false
      end
      field :role do
        searchable false
      end
      field :veterinarian do
        filterable false
      end
      field :sign_in_count
      field :confirmed_at
      field :failed_attempts
      field :locked_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :first_name
      field :last_name
      field :pesel
      field :phone_number
      field :email
      field :address
      field :role
      field :veterinarian
      field :sign_in_count
      field :confirmed_at
      field :failed_attempts
      field :locked_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :created_at
      field :updated_at
    end

    create do
      field :first_name
      field :last_name
      field :pesel
      field :phone_number
      field :email do
        required true
      end
      field :password do
        required true
      end
      field :password_confirmation do
        required true
      end
      field :role
      field :address
      field :veterinarian
      # field :confirmed_at, :hidden do
      #   default_value do
      #     DateTime.now + 2.minutes
      #   end
      # end
    end

    update do
      field :first_name
      field :last_name
      field :pesel
      field :phone_number
      field :email do
        required true
      end
      field :password
      field :password_confirmation
      field :role
      field :address
      field :veterinarian
      field :sign_in_count
      field :confirmed_at
      field :failed_attempts
      field :locked_at
    end

    export do
      field :id
      field :first_name
      field :last_name
      field :pesel
      field :phone_number
      field :email
      field :address
      field :role
      field :veterinarian
      field :sign_in_count
      field :confirmed_at
      field :failed_attempts
      field :locked_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :created_at
      field :updated_at
    end
  end

  config.model 'Animal' do
    configure :user do
      label "Utilisateur"
    end

    configure :species do
      label "Espèce"
    end

    configure :medical_records do
      label "Fiche client"
    end

    configure :pictures do
      label "Images"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :id_number
      field :name
      field :birth_date
      field :amount
      field :weight
      field :species do
        filterable false
      end
      field :gender do
        searchable false
      end
      field :age
      field :description
      field :user do
        filterable false
      end
      field :medical_records do
        filterable false
      end
      field :pictures do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :id_number
      field :name
      field :birth_date
      field :amount
      field :weight
      field :species
      field :gender
      field :age
      field :description
      field :user
      field :medical_records
      field :pictures
      field :created_at
      field :updated_at
    end

    create do
      field :id_number
      field :name
      field :birth_date
      field :amount
      field :weight
      field :species do
        inline_add false
        inline_edit false
      end
      field :gender
      field :age
      field :description
      field :user do
        inline_add false
        inline_edit false
      end
    end

    update do
      field :id_number
      field :name
      field :birth_date
      field :amount
      field :weight
      field :species do
        inline_add false
        inline_edit false
      end
      field :gender
      field :age
      field :description
      field :user do
        inline_add false
        inline_edit false
      end
      field :medical_records do
        inline_add false
      end
      field :pictures do
        inline_add false
      end
    end

    export do
      field :id
      field :id_number
      field :name
      field :birth_date
      field :amount
      field :weight
      field :gender
      field :age
      field :description
      field :created_at
      field :updated_at
      field :species
      field :user
      field :medical_records
      field :pictures
    end
  end

  config.model 'Appointment' do
    configure :user do
      label "Utilisateur"
    end

    configure :veterinarian do
      label "Vétérinaire"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :day
      field :time do
        searchable false
      end
      field :status do
        searchable false
      end
      field :kind do
        searchable false
      end
      field :description
      field :user do
        filterable false
      end
      field :veterinarian do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :day
      field :time
      field :status
      field :kind
      field :description
      field :user
      field :veterinarian
      field :created_at
      field :updated_at
    end

    edit do
      field :day
      field :time
      field :status
      field :kind
      field :user do
        inline_add false
        inline_edit false
      end
      field :veterinarian do
        inline_add false
        inline_edit false
      end
      field :description
    end

    export do
      field :id
      field :status
      field :kind
      field :description
      field :day
      field :time
      field :created_at
      field :updated_at
      field :user
      field :veterinarian
    end
  end

  config.model 'Disease' do
    configure :medical_records do
      label "Fichier patient"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :name
      field :status do
        searchable false
      end
      field :medical_records do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :name
      field :status
      field :medical_records
      field :created_at
      field :updated_at
    end

    create do
      field :name
    end

    update do
      field :name
      field :status
      field :medical_records do
        inline_add false
      end
    end

    export do
      field :id
      field :name
      field :status
      field :created_at
      field :updated_at
      field :medical_records
    end
  end

  config.model 'MedicalRecord' do
    configure :user do
      label "Propriétaire"
    end

    configure :veterinarian do
      label "Vétérinaire"
    end

    configure :animals do
      label "Animal"
    end

    configure :diseases do
      label "Maladie"
    end

    configure :medicines do
      label "Vétérinaire"
    end

    configure :pictures do
      label "Image"
    end

    configure :treatments do
      label "Traitement"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :user do
        filterable false
      end
      field :veterinarian do
        filterable false
      end
      field :animals do
        filterable false
      end
      field :anamnesis
      field :diseases do
        filterable false
      end
      field :medicines do
        filterable false
      end
      field :pictures do
        filterable false
      end
      field :treatments do
        filterable false
      end
      field :comment
      field :description
      field :additional_cost
      field :total_cost
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :user
      field :veterinarian
      field :animals
      field :anamnesis
      field :diseases
      field :medicines
      field :pictures
      field :treatments
      field :comment
      field :description
      field :additional_cost
      field :total_cost
      field :created_at
      field :updated_at
    end

    edit do
      field :user do
        inline_add false
        inline_edit false
      end
      field :veterinarian do
        inline_add false
        inline_edit false
      end
      field :animals do
        inline_add false
      end
      field :anamnesis
      field :diseases do
        inline_add false
      end
      field :medicines do
        nested_form false
        inline_add false
      end
      field :pictures do
        inline_add false
      end
      field :treatments do
        inline_add false
      end
      field :comment
      field :description
      field :additional_cost
    end

    export do
      field :id
      field :anamnesis
      field :comment
      field :description
      field :additional_cost
      field :total_cost
      field :created_at
      field :updated_at
      field :user
      field :veterinarian
      field :animals
      field :diseases
      field :medicines
      field :pictures
      field :treatments
    end
  end

  config.model 'Medicine' do
    configure :unit do
      label "Unité"
    end

    configure :medical_records do
      label "Fiche client"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :name
      field :amount
      field :unit do
        filterable false
      end
      field :dosage
      field :grace_period
      field :price
      field :serial_number
      field :description
      field :medical_records do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :name
      field :amount
      field :unit
      field :dosage
      field :grace_period
      field :price
      field :serial_number
      field :description
      field :medical_records
      field :created_at
      field :updated_at
    end

    create do
      field :name
      field :amount
      field :unit do
        inline_add false
        inline_edit false
      end
      field :dosage
      field :grace_period
      field :price
      field :serial_number
      field :description
    end

    update do
      field :name
      field :amount
      field :unit do
        inline_add false
        inline_edit false
      end
      field :dosage
      field :grace_period
      field :price
      field :serial_number
      field :description
      field :medical_records do
        inline_add false
      end
    end

    export do
      field :id
      field :name
      field :amount
      field :unit
      field :dosage
      field :grace_period
      field :price
      field :serial_number
      field :description
      field :medical_records
      field :created_at
      field :updated_at
    end
  end

  config.model 'Picture' do
    configure :user do
      label "Utilisateur"
    end

    configure :medical_records do
      label "Fiche client"
    end

    configure :animal do
      label "Animal"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :name
      field :description
      field :image
      field :user do
        filterable false
      end
      field :medical_records do
        filterable false
      end
      field :animal do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :name
      field :description
      field :image
      field :user
      field :medical_records
      field :animal
      field :created_at
      field :updated_at
    end

    create do
      field :name
      field :description
      field :image
      field :user do
        inline_add false
        inline_edit false
      end
      field :animal do
        inline_add false
        inline_edit false
      end
    end

    update do
      field :name
      field :description
      field :image
      field :user do
        inline_add false
        inline_edit false
      end
      field :medical_records do
        inline_add false
      end
      field :animal do
        inline_add false
        inline_edit false
      end
    end

    export do
      field :id
      field :name
      field :description
      field :image
      field :created_at
      field :updated_at
      field :user
      field :medical_records
      field :animal
    end
  end

  config.model 'Species' do
    configure :animal do
      label "zwierzęta"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :name
      field :status do
        searchable false
      end
      field :animal do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :name
      field :status
      field :animal
      field :created_at
      field :updated_at
    end

    create do
      field :name
    end

    update do
      field :name
      field :status
      field :animal do
        inline_add false
      end
    end

    export do
      field :id
      field :name
      field :status
      field :created_at
      field :updated_at
      field :animal
    end
  end

  config.model 'Treatment' do
    configure :medical_records do
      label "Fiche client"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :name
      field :status do
        searchable false
      end
      field :cost
      field :description
      field :medical_records do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :name
      field :cost
      field :status
      field :description
      field :medical_records
      field :created_at
      field :updated_at
    end

    create do
      field :name
      field :cost
      field :description
    end

    update do
      field :name
      field :cost
      field :status
      field :description
      field :medical_records do
        inline_add false
      end
    end

    export do
      field :id
      field :name
      field :cost
      field :status
      field :description
      field :created_at
      field :updated_at
      field :medical_records
    end
  end

  config.model 'Unit' do
    configure :medicines do
      label "lekarstwa"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :name
      field :status do
        searchable false
      end
      field :medicines do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :name
      field :status
      field :medicines
      field :created_at
      field :updated_at
    end

    create do
      field :name
    end

    update do
      field :name
      field :status
      field :medicines do
        inline_add false
      end
    end

    export do
      field :id
      field :name
      field :status
      field :created_at
      field :updated_at
      field :medicines
    end
  end

  config.model 'Vacation' do
    configure :veterinarian do
      label "Vétérinaire"
    end

    object_label_method do
      :custom_label_method
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :start
      field :end
      field :veterinarian do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :start
      field :end
      field :veterinarian
      field :created_at
      field :updated_at
    end

    edit do
      field :start
      field :end
      field :veterinarian do
        inline_add false
        inline_edit false
      end
    end

    export do
      field :id
      field :start
      field :end
      field :created_at
      field :updated_at
      field :veterinarian
    end
  end

  config.model 'Veterinarian' do
    configure :user do
      label "Utilisateur"
    end

    configure :medical_records do
      label "Fiche client"
    end

    configure :appointments do
      label "Rendez-vous"
    end

    configure :vacations do
      label "Vacances"
    end

    configure :working_day do
      label "Jour de travail"
    end

    object_label_method do
      :custom_label_method
    end

    nested do
      configure :user do
        hide
      end

      configure :medical_records do
        hide
      end

      configure :appointments do
        hide
      end

      configure :vacations do
        hide
      end

      configure :working_day do
        label "Jour de travail"
      end
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :title
      field :specialization
      field :pwz
      field :user do
        filterable false
      end
      field :appointments do
        filterable false
      end
      field :vacations do
        filterable false
      end
      field :working_day do
        filterable false
      end
      field :medical_records do
        filterable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :title
      field :specialization
      field :pwz
      field :user
      field :appointments
      field :vacations
      field :working_day
      field :medical_records
      field :created_at
      field :updated_at
    end

    create do
      field :title
      field :specialization
      field :pwz
      field :user do
        inline_add false
        inline_edit false
      end
      field :working_day
    end

    update do
      field :title
      field :specialization
      field :pwz
      field :user do
        inline_add false
        inline_edit false
      end
      field :appointments do
        inline_add false
      end
      field :vacations do
        inline_add false
      end
      field :working_day do
        inline_add false
        inline_edit false
      end
      field :medical_records do
        inline_add false
      end
    end

    export do
      field :id
      field :title
      field :specialization
      field :pwz
      field :created_at
      field :updated_at
      field :user
      field :appointments
      field :vacations
      field :working_day
      field :medical_records
    end
  end

  config.model 'WorkingDay' do
    configure :veterinarian do
     label 'Vétérinaire'
    end

    object_label_method do
      :custom_label_method
    end

    nested do
      configure :veterinarian do
        hide
      end
    end

    list do
      sort_by :id

      field :id do
        sort_reverse false
      end
      field :veterinarian do
        filterable false
      end
      field :monday
      field :tuesday
      field :wednesday
      field :thursday
      field :friday
      field :saturday
      field :sunday
      field :created_at
      field :updated_at
    end

    show do
      field :id
      field :veterinarian
      field :monday
      field :tuesday
      field :wednesday
      field :thursday
      field :friday
      field :saturday
      field :sunday
      field :created_at
      field :updated_at
    end

    edit do
      field :veterinarian do
        inline_add false
        inline_edit false
      end
      field :monday
      field :tuesday
      field :wednesday
      field :thursday
      field :friday
      field :saturday
      field :sunday
    end

    export do
      field :id
      field :monday
      field :tuesday
      field :wednesday
      field :thursday
      field :friday
      field :saturday
      field :sunday
      field :created_at
      field :updated_at
      field :veterinarian
    end
  end
end
