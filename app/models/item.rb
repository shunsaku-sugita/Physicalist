class Item < ApplicationRecord
  validates :jan_code, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :artist, presence: true, length: { maximum: 255 }
  validates :item_url, presence: true, length: { maximum: 255 }
  validates :jacket_url, presence: true, length: { maximum: 255 }
  validates :release_date, presence: true, length: { maximum: 50 }
  
  has_many :ownerships
  has_many :users, through: :ownerships
  
  # Want
  has_many :wants
  has_many :want_users, through: :wants, class_name: 'User', source: :user
  
  # Have
  has_many :haves, class_name: 'Have'
  has_many :have_users, through: :haves, class_name: 'User', source: :user
end