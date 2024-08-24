class Vendedor < ApplicationRecord
  after_initialize :set_default_values, if: :new_record?

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :review_vendedors, dependent: :destroy

  has_many :produtos, dependent: :destroy
  accepts_nested_attributes_for :produtos, reject_if: :all_blank, allow_destroy: true

  validates :email_para_contato, presence: true
  validates :cnpj, uniqueness: true

  def totalVendas
    Historico.where(vendedor_nome: self.user.nome).count
  end

  def calcular_nota
    if review_vendedors.any?
      somaNotas = review_vendedors.sum(:nota)
      nota = somaNotas / review_vendedors.count.to_f
      nota.round(1)
    else
      "Sem Reviews"
    end
  end

  private

  def set_default_values
    self.carteira ||= 0.0
  end
end
