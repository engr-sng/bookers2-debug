class Group < ApplicationRecord

  belongs_to :user
  has_many :group_users, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true, length: { maximum: 140 }

end
