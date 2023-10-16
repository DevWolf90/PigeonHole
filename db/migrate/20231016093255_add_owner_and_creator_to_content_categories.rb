class AddOwnerAndCreatorToContentCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :content_categories, :owner, foreign_key: { to_table: :users }
    add_reference :content_categories, :creator, foreign_key: { to_table: :users }
  end
end
