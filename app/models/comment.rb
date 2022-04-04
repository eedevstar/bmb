class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  default_scope { order(created_at: :asc) }

  validates :body, presence: true

  after_create_commit { broadcast_append_to "comments" }
end
