require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザ登録ができる時' do
      it 'nicknameとemail、password、password_confirmation、family_name_zenkaku、first_name_zenkaku、family_name_katakana、first_name_katakanaが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザ登録ができない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'testtest'
        @user.password_confirmation = 'testtest'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'テストtest123'
        @user.password_confirmation = 'テストtest123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = 'hoge1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a0000'
        @user.password_confirmation = 'a0000'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end

      it 'family_name_zenkakuが空では登録できない' do
        @user.family_name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（姓）を入力してください")
      end

      it 'first_name_zenkakuが空では登録できない' do
        @user.first_name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（名）を入力してください")
      end

      it 'family_name_katakanaが空では登録できない' do
        @user.family_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（セイ）を入力してください")
      end

      it 'first_name_katakanaが空では登録できない' do
        @user.first_name_katakana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ（メイ）を入力してください")
      end

      it 'family_name_zenkakuが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.family_name_zenkaku = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（姓）は不正な値です')
      end

      it 'first_name_zenkakuが全角（漢字・ひらがな・カタカナ）以外では登録できない' do
        @user.first_name_zenkaku = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名）は不正な値です')
      end

      it 'family_name_katakanaが全角（カタカナ）以外では登録できない' do
        @user.family_name_katakana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（セイ）は不正な値です')
      end

      it 'first_name_katakanaが全角（カタカナ）以外では登録できない' do
        @user.first_name_katakana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（メイ）は不正な値です')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
