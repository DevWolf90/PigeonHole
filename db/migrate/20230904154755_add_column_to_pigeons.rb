class AddColumnToPigeons < ActiveRecord::Migration[7.0]
  def change
    add_column :pigeons, :message, :references
  end
end
