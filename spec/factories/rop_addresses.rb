FactoryBot.define do
  factory :rop_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipality { 'ほげ市' }
    address { '1-1' }
    building_name { 'アパートふが' }
    tel { '09012345678' }
  end
end
