class Group < ApplicationRecord

  belongs_to :user

  validates :name, presence: true
  validates :introduction, presence: true, length: { maximum: 140 }

end
