class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.references :medical_profile, foreign_key: true
      t.date :date
      t.text :address
			
      t.timestamps
    end
  end
end
