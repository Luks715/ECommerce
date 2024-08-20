class User < ApplicationRecord
  after_initialize :create_default_carrinho, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  enum role: {Cliente: 0, Vendedor: 1}

  validates :nome, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
  validates :telefone, presence: true, uniqueness: true
  validates :endereco, presence: true
  validates :role, presence: true

  has_one :carrinho
  has_one :cliente
  has_one :vendedor

  private
  def create_default_carrinho
    self.build_carrinho if carrinho.nil?
  end
end
