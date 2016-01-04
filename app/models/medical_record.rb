class MedicalRecord < ActiveRecord::Base
  belongs_to :user
  belongs_to :veterinarian
  has_and_belongs_to_many :animals
  has_and_belongs_to_many :diseases
  has_and_belongs_to_many :medicines
  has_and_belongs_to_many :treatments
  has_and_belongs_to_many :pictures

  before_save :total_price

  accepts_nested_attributes_for :medicines, allow_destroy: true

  def total_price
    sum = medicines.inject(0.0) { |sum, medicine| sum + medicine.price }
    sum += treatments.inject(0.0) { |sum, treatment| sum + treatment.cost  }
    self.total_cost = additional_cost.to_f + sum
  end

  def custom_label_method
    "##{id} Propriétaire: #{user.try(:decorate).try(:full_name)}, Vétérinaire: #{veterinarian.try(:user).try(:decorate).try(:full_name)}"
  end

  private

    def self.search(query, user_id)
      where("(id::varchar(255) like :q OR to_char(created_at, 'YYYY-MM-DD') like :q) AND user_id = :u", { q: "%#{query}%", u: user_id })
    end
end
