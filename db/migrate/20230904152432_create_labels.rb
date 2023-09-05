class CreateLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :labels do |t|
      t.references :pigeon, null: false, foreign_key: true
      t.references :content_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
