class Comment < ApplicationRecord
  belongs_to :post

  validates :name, presence: true, format: { with: Devise.email_regexp }
  validates :content, presence: true
end
