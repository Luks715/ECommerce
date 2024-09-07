class Cliente < ApplicationRecord
  after_initialize :set_default_saldo, if: :new_record?

  belongs_to :user, inverse_of: :cliente
  has_many :reviews

  #tabela de associação entre vendedores que o cliente pode avaliar
  has_many :vendedor, through: :cliente_vendedores, source: :cliente_vendedores_table

  validates :saldo, numericality: { greater_than_or_equal_to: 0.00 }
  validates :cpf, uniqueness: true

  def compras
    Historico.where(cliente_nome: self.user.nome).count
  end

  private
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
end
