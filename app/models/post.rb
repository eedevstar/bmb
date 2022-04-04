class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope { order(created_at: :desc) }

  # validataion
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }

  # hotfire, broadcast the result
  after_create_commit { broadcast_prepend_to "posts", locals: { current_user: User.current_user } }
  after_destroy_commit { broadcast_remove_to "posts", locals: { current_user: User.current_user } }
  after_update_commit { broadcast_replace_to "posts", locals: { current_user: User.current_user } }

end
