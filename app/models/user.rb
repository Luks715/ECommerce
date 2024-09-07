class User < ApplicationRecord
  after_initialize :create_default_carrinho, if: :new_record?

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  enum role: {Cliente: 0, Vendedor: 1}

  validates :nome, presence: true
  validates :email, presence: true, uniqueness: true
  validates :telefone, presence: true, uniqueness: true
  validates :endereco, presence: true
  validates :role, presence: true

  has_one :carrinho, dependent: :destroy

  has_one :cliente, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :cliente, allow_destroy: true

  has_one :vendedor, dependent: :destroy, inverse_of: :user
  accepts_nested_attributes_for :vendedor, allow_destroy: true


  private
  def create_default_carrinho
    self.build_carrinho if carrinho.nil?
  end
end
