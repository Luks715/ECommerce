# Controller responsável pelas ações relacionadas às páginas.
class PagesController < ApplicationController

  def home_user
    @produtos = Produto.all
    @categoria = Categorium.all
    @vendedores = Vendedor.all

    if user_signed_in?
      @usuario = User.find_by(id: current_user.id)

      if @usuario.Cliente?
        @cliente = Cliente.find_by(user_id: @usuario.id)
        @carrinho = Carrinho.find_by(user_id: @usuario.id)
      elsif @usuario.Vendedor?
        @vendedor = Vendedor.find_by(user_id: @usuario.id)
        @carrinho = Carrinho.find_by(user_id: @usuario.id)
      else
        @carrinho = []
      end
    else
      @carrinho = []
    end
  end

  def acompanhar_entrega

  end

  def search
    query = params[:q]
    @produtos = Produto.where("nome LIKE ?", "%#{query}%")

    respond_to do |format|
      format.html { render partial: 'produtos/index', locals: { produtos: @produtos } }
      format.js   # Renderiza a view search.js.erb se a requisição for AJAX
    end
  end
end
