class Review < ApplicationRecord
  belongs_to :cliente
  belongs_to :produto, optional: true
  belongs_to :vendedor, optional: true

  validates :nota, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comentario, length: { maximum: 500 }
end
