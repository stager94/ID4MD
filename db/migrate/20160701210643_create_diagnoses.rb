class CreateDiagnoses < ActiveRecord::Migration[5.0]
  def change
    create_table :diagnoses do |t|
      t.date :date
      t.string :laboratory
      t.text :address
      t.references :medical_profile, foreign_key: true

      t.timestamps
    end
  end
end
