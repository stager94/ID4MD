class AddInformationFieldsToPatients < ActiveRecord::Migration[5.0]
  def change
    add_column :patients, :first_name, :string
    add_column :patients, :last_name, :string
    add_column :patients, :diagnosis, :text
    add_column :patients, :gender, :string
    add_column :patients, :phone, :string
  end
end
