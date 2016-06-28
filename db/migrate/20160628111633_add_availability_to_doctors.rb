class AddAvailabilityToDoctors < ActiveRecord::Migration[5.0]
  def change
    add_column :doctors, :availability, :integer, default: 60
  end
end
