class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start
      t.datetime :end
      t.integer :status
      t.integer :kind
      t.references :user, index: true, foreign_key: true
      t.references :veterinarian, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
