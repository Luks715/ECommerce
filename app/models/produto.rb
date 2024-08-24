class Produto < ApplicationRecord
  belongs_to :vendedor, class_name: "Vendedor", foreign_key: "vendedor_id"
  belongs_to :categorium, class_name: "Categorium", foreign_key: "categorium_id"
  has_many :review_produtos, dependent: :destroy

  #Associação para o cliente fazer uma review do produto
  has_many :cliente_produtos, dependent: :destroy
  has_many :clientes, through: :cliente_produtos

  validates :nome, presence: true
  validates :descricao, presence: true
  validates :preco, presence: true
  validates :em_estoque, presence: true
  validates :desconto, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  validate :data_fim_deve_ser_futura, if: -> { data_fim.present? }

  def preco_promocional
    if self.emPromocao
      preco * (1 - desconto / 100.0)
    else
      self.update(desconto: 0, data_fim: nil)
      preco
    end
  end

  def emPromocao
    (desconto > 0) && data_fim.present? && (Date.today <= data_fim)
  end

  def nota
    if review_produtos.any?
      somaNotas = review_produtos.sum(:nota)
      "#{(somaNotas / review_produtos.count.to_f).round(1)}/5.0 estrelas"
    else
      "Sem reviews"
    end
  end

  def data_fim_deve_ser_futura
    if dataFim <= Date.today
      errors.add(:data_fim, "deve ser uma data futura.")
    end
  end
end
