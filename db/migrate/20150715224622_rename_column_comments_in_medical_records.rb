class RenameColumnCommentsInMedicalRecords < ActiveRecord::Migration
  def change
    rename_column :medical_records, :comments, :comment
  end
end
