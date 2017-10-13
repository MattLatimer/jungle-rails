class Review < ActiveRecord::Base

  belongs_to :product
  belongs_to :user

  validates :product_id, presence: true, numericality: {only_integer: true}
  validates :user_id, presence: true, numericality: {only_integer: true}
  validates :rating, presence: true, numericality: {only_integer: true}, inclusion: {in: (1..5)}
# TODO validate that product / user exists in database before save
end
