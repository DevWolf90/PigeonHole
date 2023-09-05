class AddDefaultToPigeons < ActiveRecord::Migration[7.0]
  def change
    change_column_default :pigeons, :favourite, false
    change_column_default :pigeons, :read, false
    change_column_default :pigeons, :reply_later, false
  end
end
