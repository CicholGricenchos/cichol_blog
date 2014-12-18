class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.integer :category_id
      t.text :body
      t.boolean :visible
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
