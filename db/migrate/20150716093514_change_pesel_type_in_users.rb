class ChangePeselTypeInUsers < ActiveRecord::Migration
  def change
    change_column :users, :pesel, :string
  end
end
