require 'rails_helper'

RSpec.describe RopAddress, type: :model do
  describe '商品購入' do
    before do
      item = FactoryBot.create(:item)
      @rop_address = FactoryBot.build(:rop_address, user_id: item.user_id, item_id: item.id)
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
        expect(@rop_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @rop_address.postal_code = '1234567'
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include('郵便番号は半角数字、ハイフンを含めて入力してください')
      end

      it 'prefectureを選択していないと保存できないこと' do
        @rop_address.prefecture_id = 1
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("都道府県を入力してください")
      end

      it 'municipalityが空だと保存できないこと' do
        @rop_address.municipality = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressが空だと保存できないこと' do
        @rop_address.address = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("番地を入力してください")
      end

      it 'telが空だと保存できないこと' do
        @rop_address.tel = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'telが半角数値のみの正しい形式でないと保存できないこと' do
        @rop_address.tel = '090-1234-5678'
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include('電話番号は不正な値です')
      end

      it 'telがが9桁以下では保存できないこと' do
        @rop_address.tel = '090123456'
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include('電話番号は10文字以上で入力してください')
      end

      it 'telが12桁以上では保存できないこと' do
        @rop_address.tel = '090123456789'
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include('電話番号は11文字以内で入力してください')
      end

      it 'tokenが空だと保存できないこと' do
        @rop_address.token = ''
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("正しいクレジットカード情報を入力してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @rop_address.user_id = nil
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @rop_address.item_id = nil
        @rop_address.valid?
        expect(@rop_address.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
