class Produto < ApplicationRecord
  belongs_to :vendedor, class_name: "Vendedor", foreign_key: "vendedor_id"
  belongs_to :categorium, class_name: "Categorium", foreign_key: "categorium_id"
  has_many :reviews

  validates :nome, presence: true
  validates :descricao, presence: true
  validates :preco, presence: true
  validates :nota, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :emEstoque, presence: true
  validates :emPromocao, inclusion: { in: [true, false] }

  private

  def calculate_nota
    if reviews.any?
      somaNotas = reviews.sum(:nota)
      self.nota = somaNotas / reviews.count.to_f
    else
      self.nota = 0
    end
    self.save
  end

  def imagem=(imagem_arquivo)
    self[:imagem] = imagem_arquivo.read if imagem_arquivo.present?
  end

  def imagem_data
    self[:imagem]
  end
end
