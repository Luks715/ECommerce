class Categorium < ApplicationRecord
  has_many :produtos

  validates :nome, presence: true
  #validates :produto_mais_vendido
end
