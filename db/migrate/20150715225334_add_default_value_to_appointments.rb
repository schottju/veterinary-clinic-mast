class AddDefaultValueToAppointments < ActiveRecord::Migration
  def change
    change_column_default :appointments, :status, 0
    change_column_default :appointments, :kind, 0
  end
end
