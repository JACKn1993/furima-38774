FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { 'test1234TEST' }
    password_confirmation { password }
    family_name_zenkaku   { person.last.kanji }
    first_name_zenkaku    { person.first.kanji }
    family_name_katakana  { person.last.katakana }
    first_name_katakana   { person.first.katakana }
    birthday              { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
  end
end
