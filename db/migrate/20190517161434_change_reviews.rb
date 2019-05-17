class ChangeReviews < ActiveRecord::Migration
  def up

    add_index :reviews, :product_id
    add_index :reviews, :user_id
    # add_index "reviews", ["products_id"], name: "index_reviews_on_products_id", using: :btree
    # add_index "reviews", ["users_id"], name: "index_reviews_on_users_id", using: :btree
    add_foreign_key :reviews, :products
    add_foreign_key :reviews, :users

  end

  def down
    remove_foreign_key :reviews, :products
    remove_foreign_key :reviews, :users
    remove_index :reviews, :products_id
    remove_index :reviews, :users_id
  end
end
