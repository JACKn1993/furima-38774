class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :rop
  has_one_attached :image
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping
  belongs_to :prefecture
  belongs_to :until_shipping

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :condition_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :shipping_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :until_shipping_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :price, format: { with: /\A[0-9]+\z/ },
                      numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000 }
  end
end
