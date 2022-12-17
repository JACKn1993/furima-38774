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
| birthday             | day    | null: false               |

### Association

- has_many :items
- has_many :rop


## items テーブル

| Column         | Type      | Options                        |
|----------------|-----------|--------------------------------|
| image          | string    | null: false                    |
| name           | string    | null: false                    |
| description    | text      | null: false                    |
| category       | string    | null: false                    |
| condition      | string    | null: false                    |
| shipping       | string    | null: false                    |
| ship_from      | string    | null: false                    |
| until_shipping | string    | null: false                    |
| price          | integer   | null: false                    |
| user_id        | reference | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :rop


## rop テーブル

| Column  | Type      | Options                        |
|---------|-----------|--------------------------------|
| user_id | reference | null: false, foreign_key: true |
| item_id | reference | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :shipping_address


## shipping_address テーブル

| Column         | Type      | Options                        |
|----------------|-----------|--------------------------------|
| postal_code    | string    | null: false                    |
| prefecture     | string    | null: false                    |
| municipalities | string    | null: false                    |
| address        | string    | null: false                    |
| building_name  | string    |                                |
| tel            | string    | null: false                    |
| rop_id         | reference | null: false, foreign_key: true |

### Association

- belongs_to :rop