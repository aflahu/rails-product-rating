# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string
#  price      :decimal(, )
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Product < ApplicationRecord
  has_many :purchases
  belongs_to :store
  
  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  
  validate :quantity_within_limit
  
  def quantity_within_limit
    return unless quantity

    if quantity < 0
      errors.add(:quantity, 'too few')
    end
  end

end
