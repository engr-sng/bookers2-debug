class Room < ApplicationRecord
  has_many :room_enters, dependent: :destroy
  has_many :rooms, through: :room_enters
  has_many :messages, dependent: :destroy
end
