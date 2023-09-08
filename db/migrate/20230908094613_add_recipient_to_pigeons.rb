class AddRecipientToPigeons < ActiveRecord::Migration[7.0]
  def change
    add_reference :pigeons, :recipient, null: false, foreign_key: { to_table: :users }
  end
end
