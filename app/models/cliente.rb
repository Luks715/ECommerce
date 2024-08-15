class Cliente < ApplicationRecord
  after_initialize :set_default_saldo, if: :new_record?
  after_initialize :create_default_carrinho, if: :new_record?

  belongs_to :user
  has_many :pedidos
  has_one :carrinho
  has_one :historico
  has_many :review
  #tabela de associação entre vendedores que o cliente pode avaliar
  has_many :vendedor, through: :cliente_vendedores, source: :cliente_vendedores_table

  validates :saldo, numericality: { greater_than_or_equal_to: 0.00 }

  private
  def create_default_carrinho
    self.build_carrinho if carrinho.nil?
  end

  def set_default_saldo
    self.saldo ||= 0.0
  end

  def adicionar_saldo(valor)
    if valor.negative?
      return false
    end

    self.saldo += valor
    save
    return true
  end

  def avaliar_vendedor(vendedor, avaliacao)
    if()
      vendedor.somaNotas += avaliacao
      vendedor.avaliacoesRecebidas += 1
      vendedor.save
      return true
    else
      return false
    end
  end
end
