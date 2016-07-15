class CreateChatMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_messages do |t|
      t.text :body
      t.integer :objectable_id
      t.string :objectable_type
      t.references :medical_profile, foreign_key: true
      t.integer :sender_id
      t.string :sender_type

      t.timestamps
    end
  end
end
