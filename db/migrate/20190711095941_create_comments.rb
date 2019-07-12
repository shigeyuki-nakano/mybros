class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.string :content, null: false
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
