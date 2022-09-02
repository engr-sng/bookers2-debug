class BookTag < ApplicationRecord

  belongs_to :tag
  belongs_to :book

  validates :book_id, presence: true
  validates :tag_id, presence: true

end
