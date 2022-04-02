class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }

  default_scope { order(created_at: :desc) }
  scope :user_records, -> (user_id) { where(user_id: user_id) }

  def post_time
    created_at.strftime("%B %e, %Y")
  end


end
