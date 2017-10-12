class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :jan_code
      t.string :title
      t.string :artist
      t.string :item_url
      t.string :jacket_url
      t.string :release_date

      t.timestamps
    end
  end
end
