class Album < ApplicationRecord
  validates :artist, presence: true
  validates :title, presence: true
  belongs_to :user
end
