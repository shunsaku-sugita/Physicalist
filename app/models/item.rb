class Item < ApplicationRecord
  validates :jan_code, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :artist, presence: true, length: { maximum: 255 }
  validates :item_url, presence: true, length: { maximum: 255 }
  validates :jacket_url, presence: true, length: { maximum: 255 }
  validates :release_date, presence: true, length: { maximum: 50 }
end