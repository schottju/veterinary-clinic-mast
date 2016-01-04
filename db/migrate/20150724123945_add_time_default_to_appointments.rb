class AddTimeDefaultToAppointments < ActiveRecord::Migration
  def change
    change_column :appointments, :time, :integer, default: 0
  end
end
