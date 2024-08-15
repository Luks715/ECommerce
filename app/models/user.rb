class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable
  enum role: {Cliente: 0, Vendedor: 1, Visitante: 2}

  validates :nome, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
  validates :telefone, presence: true, uniqueness: true
  validates :endereco, presence: true
  validates :role, presence: true

  has_one :cliente
  has_one :vendedor

  private

  def role_instance
    return vendedor if vendedor?
    return cliente if cliente?
    return visitante if visitante?
    nil
  end
end
