class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :house_number
      t.string :flat_number
      t.string :city
      t.string :borough
      t.string :district
      t.string :province
      t.string :country

      t.timestamps null: false
    end
  end
end
