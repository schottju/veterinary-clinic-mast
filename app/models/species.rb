class Species < ActiveRecord::Base
  enum status: [ :odblokowany, :zablokowany ]

  has_many :animal

  validates_presence_of :name, :status

  def custom_label_method
    "##{id} #{name} #{"(zablokowane)" if status == "zablokowany"}"
  end

  private

  def self.search(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end
end
