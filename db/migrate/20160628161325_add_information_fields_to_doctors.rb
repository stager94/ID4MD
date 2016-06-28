class AddInformationFieldsToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :gender, :string
    add_column :doctors, :speciality, :text
    add_column :doctors, :first_name, :string
    add_column :doctors, :last_name, :string
    add_column :doctors, :phone, :string
  end
end
