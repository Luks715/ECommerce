class VendedorsController < ApplicationController
  before_action :set_vendedor

  def index
    @vendedores = Vendedor.all
  end

  def show
    @usuario = @vendedor.user
    @produtos = @vendedor.produtos
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

  def set_vendedor
    @vendedor = Vendedor.find(params[:id])
  end
end
