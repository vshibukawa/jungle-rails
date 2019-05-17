class Review < ActiveRecord::Base
  belongs_to :products
  belongs_to :users

  validates :product_id,  presence: true
  validates :user_id,     presence: true
  validates :description, presence: true
  validates :rating,      presence: true
end
