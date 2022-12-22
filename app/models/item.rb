class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :condetion
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :until_shipping
end
