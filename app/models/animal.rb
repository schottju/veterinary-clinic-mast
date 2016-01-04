class Animal < ActiveRecord::Base
  enum gender: [ :male, :femelle, :neutered ]

  belongs_to :species
  belongs_to :user
  has_many :pictures
  has_and_belongs_to_many :medical_records

  validates_presence_of :amount, :gender, :species_id

  def custom_label_method
    "##{id} ID: #{id_number}, imię: #{name}, wiek: #{trim(age)}, ilość: #{amount}, gatunek: #{species.try(:name)}"
  end

  private

    def self.search(query, user_id)
      where("(lower(id_number) like :q OR lower(name) like :q) AND user_id = :u", { q: "%#{query.downcase}%", u: user_id })
    end

    def trim(num)
      if num.blank?
        "brak"
      else
        i, f = num.to_i, num.to_f
        i == f ? i : f
      end
    end
end
