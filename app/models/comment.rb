class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true

  def comment_time
    created_at.strftime("%B %e, %Y")
  end

end
