class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews, force: :cascade do |t|
      t.string :description
      t.integer :rating
      t.integer :product_id
      t.integer :user_id
      # t.references :products, index: true, foreign_key: true
      # t.references :users, index: true, foreign_key: true

      t.timestamps null: false
    end

  end

  def down
    drop_table :reviews
  end
end
