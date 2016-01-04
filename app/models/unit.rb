class Unit < ActiveRecord::Base
  enum status: [ :valide, :zablokowany ]

  has_many :medicines

  validates_presence_of :name, :status

  def custom_label_method
    "##{id} #{name} #{"(zablokowane)" if status == "zablokowany"}"
  end

  private

  def self.search(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end
end
