class AddUserToPigeon < ActiveRecord::Migration[7.0]
  def change
    add_reference :pigeons, :user, null: false, foreign_key: true
  end
end
