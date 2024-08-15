class VendedorsController < ApplicationController
  def index
    @vendedores = Vendedor.all
  end
end
