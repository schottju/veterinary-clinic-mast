class ChangeColumnsInAppointments < ActiveRecord::Migration
  def change
    remove_column :appointments, :start
    remove_column :appointments, :end
    add_column :appointments, :day, :date
    add_column :appointments, :time, :integer
  end
end
