class CreateSearchResults < ActiveRecord::Migration[5.1]
  def change
    create_table :search_results do |t|
      t.string :keyword, null: false
      t.integer :total_results, null: false, default: 0
      t.integer :total_links, null: false, default: 0
      t.text :html_code, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
