class Treatment < ActiveRecord::Base
  enum status: [ :odblokowany, :zablokowany ]

  has_and_belongs_to_many :medical_records

  validates_presence_of :name, :status

  def custom_label_method
    "##{id} #{name} #{"(invalide)" if status == "zablokowany"}"
  end

  private

  def self.search(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end

  def self.price_page_search(query)
    where("(lower(name) like :q OR lower(description) like :q) AND status = 0", q: "%#{query.downcase}%")
  end
end
