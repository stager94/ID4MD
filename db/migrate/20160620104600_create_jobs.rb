class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.references :doctor, foreign_key: true
      t.string :name
      t.text :address

      t.timestamps
    end
  end
end
