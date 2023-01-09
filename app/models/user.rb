class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :family_name_zenkaku, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :first_name_zenkaku, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
    validates :family_name_katakana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_katakana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :birthday
  end

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX }

  has_many :items
  has_many :rops
end
