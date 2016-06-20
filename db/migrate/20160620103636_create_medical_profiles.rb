class CreateMedicalProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :medical_profiles do |t|
      t.references :patient, foreign_key: true
      t.references :doctor, foreign_key: true
      t.text :diagnosis

      t.timestamps
    end
  end
end
