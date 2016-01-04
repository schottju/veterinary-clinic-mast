class Medicine < ActiveRecord::Base
  belongs_to :unit
  has_and_belongs_to_many :medical_records

  validates_presence_of :name, :amount, :unit_id

  def custom_label_method
    "##{id} #{name}, ilość: #{amount} #{unit.try(:name)}"
  end
end
