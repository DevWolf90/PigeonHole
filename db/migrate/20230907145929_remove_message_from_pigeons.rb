class RemoveMessageFromPigeons < ActiveRecord::Migration[7.0]
  def change
    remove_reference :pigeons, :message, null: false, foreign_key: true
    add_reference :pigeons, :chat, null: false, foreign_key: true
  end
end
