class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.references :sender, null: false
      t.references :recipient, null: false

      t.timestamps
    end
    add_foreign_key :chats, :users, column: :sender_id, primary_key: :id
    add_foreign_key :chats, :users, column: :recipient_id, primary_key: :id
  end
end
