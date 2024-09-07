class ClientesController < ApplicationController
  before_action :set_cliente

  def show
    @usuario = @cliente.user
    @carrinho = @usuario.carrinho
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def set_cliente
    @cliente = Cliente.find(params[:id])
  end
end
