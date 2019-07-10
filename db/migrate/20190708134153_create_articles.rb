class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :article
      t.string :title_image
      t.string :article_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
