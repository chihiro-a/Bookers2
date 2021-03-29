class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  # 空欄不可
  validates :body, length: {maximum: 200}, presence: true
  # 空欄不可、２００字以内
end
