class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :room_enters, dependent: :destroy
  has_many :rooms, through: :room_enters
  has_many :messages, dependent: :destroy

  has_many :view_counts, dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,  length: { maximum: 50 }

  def relationships_by?(current_user, user)
    Relationship.find_by(follower_id: current_user.id, followed_id: user.id)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end

  def self.guest
    find_or_create_by!(name: "guestuser", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def post_count(from_day,to_day)
    self.books.where(created_at: (Time.zone.now.beginning_of_day - from_day.day)..(Time.zone.now.end_of_day - to_day.day)).count
  end

end
