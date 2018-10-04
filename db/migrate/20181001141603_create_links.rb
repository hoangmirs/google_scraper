class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.integer :link_type, null: false, default: 0
      t.string :title, null: false
      t.string :url, null: false
      t.references :search_result, foreign_key: true

      t.timestamps
    end
  end
end
