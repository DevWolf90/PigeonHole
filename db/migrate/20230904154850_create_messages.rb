class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :sender, null: false
      t.text :content
      t.date :date

      t.timestamps
    end
    add_foreign_key :messages, :users, column: :sender_id, primary_key: :id
  end
end
