## users テーブル

| Column               | Type   | Options                   |
|----------------------|--------|---------------------------|
| nicname              | string | null: false               |
| email                | string | null: false, unique: true |
| encrypted_password   | string | null: false               |
| family_name_zenkaku  | string | null: false               |
| first_name_zenkaku   | string | null: false               |
| family_name_katakana | string | null: false               |
| first_name_katakana  | string | null: false               |
| birthday             | date    | null: false               |

### Association

- has_many :items
- has_many :rops


## items テーブル

| Column            | Type      | Options                        |
|-------------------|-----------|--------------------------------|
| name              | string    | null: false                    |
| description       | text      | null: false                    |
| category_id       | integer   | null: false                    |
| condition_id      | integer   | null: false                    |
| prefecture_id     | integer   | null: false                    |
| ship_from_id      | integer   | null: false                    |
| until_shipping_id | integer   | null: false                    |
| price             | integer   | null: false                    |
| user              | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :rop


## rops テーブル

| Column | Type      | Options                        |
|--------|-----------|--------------------------------|
| user   | reference | null: false, foreign_key: true |
| item   | reference | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :shipping_address


## shipping_addresses テーブル

| Column         | Type      | Options                        |
|----------------|-----------|--------------------------------|
| postal_code    | string    | null: false                    |
| prefecture_id  | string    | null: false                    |
| municipalities | string    | null: false                    |
| address        | string    | null: false                    |
| building_name  | string    |                                |
| tel            | string    | null: false                    |
| rop            | reference | null: false, foreign_key: true |

### Association

- belongs_to :rop