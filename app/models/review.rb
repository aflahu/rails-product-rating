# == Schema Information
#
# Table name: reviews
#
#  id          :bigint           not null, primary key
#  comment     :string
#  rating      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  purchase_id :bigint
#
# Indexes
#
#  index_reviews_on_purchase_id  (purchase_id)
#
# Foreign Keys
#
#  fk_rails_...  (purchase_id => purchases.id)
#
class Review < ApplicationRecord
  belongs_to :purchase

  validates :rating, presence: true, numericality: { only_integer: true }
  validates :comment, presence: true

  validate :rating_within_limit
  
  def rating_within_limit
    return unless rating
    # COMPLETED: Implement validation logic for `rating`
    # - Rating cannot be greater than 5    
    # - Rating cannot be a negative number
    # - Handle any potential error/crash
    if rating > 5 || rating < 0
      errors.add("Rating cannot be greater than 5 and cannot be a negative ")
    end
  end
end
