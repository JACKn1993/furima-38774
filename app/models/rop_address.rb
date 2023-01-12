class RopAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :municipality, :address, :building_name, :tel, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は半角数字、ハイフンを含めて入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
    validates :municipality
    validates :address
    validates :tel, length: { in: 10..11 }, format: { with: /\A[0-9]+\z/ }
    validates :token
  end

  def save
    rop = Rop.create(user_id: user_id, item_id: item_id)

    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: address,
                   building_name: building_name, tel: tel, rop_id: rop.id)
  end
end
