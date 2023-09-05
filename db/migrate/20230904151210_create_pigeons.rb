class CreatePigeons < ActiveRecord::Migration[7.0]
  def change
    create_table :pigeons do |t|
      t.text :description
      t.string :title
      t.date :date
      t.boolean :favourite
      t.boolean :read
      t.string :media_type
      t.boolean :reply_later
      t.string :link_to_content
      t.text :summary
      t.integer :length

      t.timestamps
    end
  end
end
