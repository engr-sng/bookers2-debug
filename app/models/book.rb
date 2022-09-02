class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :view_counts, dependent: :destroy
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }, presence: true


  def favorites_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tag(send_tags)
    send_tags.to_s.split(",").each do |send_tag|
      if Tag.find_by(name: send_tag).nil?
        Tag.create(name: send_tag)
      end
    end

    send_tags.to_s.split(",").each do |send_tag|
      tag = Tag.find_by(name: send_tag)
      BookTag.create(tag_id: tag.id, book_id: self.id)
    end
  end
end
