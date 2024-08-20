class ClienteProduto < ApplicationRecord
  belongs_to :cliente
  belongs_to :produto
end
