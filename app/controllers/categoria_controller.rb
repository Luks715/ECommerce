class CategoriaController < ApplicationController
  def index
    @categoria = Categorium.all
    respond_to do |format|
      format.html # Para requests normais
      format.js   # Para requests via Ajax
    end
  end
end
