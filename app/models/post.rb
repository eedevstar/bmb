class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }

  default_scope { order(created_at: :desc) }
  scope :user_records, -> (user_id) { where(user_id: user_id) }

  after_create_commit { broadcast_prepend_to "posts" }
  after_destroy_commit { broadcast_remove_to "posts" }
  after_update_commit { broadcast_replace_to "posts" }

end
