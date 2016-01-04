class Disease < ActiveRecord::Base
  enum status: [ :odblokowany, :zablokowany ]

  has_and_belongs_to_many :medical_records

  validates_presence_of :name, :status

  def custom_label_method
    "##{id} #{name} #{"(zablokowane)" if status == "zablokowany"}"
  end

  private

  def self.search(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end
end
