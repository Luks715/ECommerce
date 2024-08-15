class Historico < ApplicationRecord
  belongs_to :cliente, class_name: "cliente", foreign_key: "cliente_id"
  has_one :pedido

  validates :dataDeCompra
end
