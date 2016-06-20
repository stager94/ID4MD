class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.date :date
      t.text :text
      t.references :medical_profile, foreign_key: true

      t.timestamps
    end
  end
end
