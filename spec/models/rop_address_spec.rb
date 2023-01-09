require 'rails_helper'

RSpec.describe RopAddress, type: :model do
  describe '商品購入' do
    before do
      item = FactoryBot.create(:item)
      @rop_address = FactoryBot.build(:rop_address, user_id: item.user_id, item_id: item.id, token: 'a1a1a1')
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@rop_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @rop_address.building_name = ''
        expect(@rop_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @rop_address.postal_code = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @rop_address.postal_code = '1234567'
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureを選択していないと保存できないこと' do
        @rop_address.prefecture_id = 1
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'municipalityが空だと保存できないこと' do
        @rop_address.municipality = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'addressが空だと保存できないこと' do
        @rop_address.address = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'telが空だと保存できないこと' do
        @rop_address.tel = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Tel can't be blank")
      end

      it 'telが半角数値のみの正しい形式でないと保存できないこと' do
        @rop_address.tel = '090-1234-5678'
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include('Tel is not a number')
      end

      it 'tokenが空だと保存できないこと' do
        @rop_address.token = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @rop_address.user_id = nil
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @rop_address.item_id = nil
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
