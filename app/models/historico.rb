class Historico < ApplicationRecord
  belongs_to :cliente
  belongs_to :produto
  validates :quantidade, presence: true, numericality: { greater_than: 0 }
end
