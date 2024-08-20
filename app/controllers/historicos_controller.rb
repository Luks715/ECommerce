class HistoricosController < ApplicationController
  before_action :set_historico
  def index

  end

  def new
    @historico = Historico.new
  end

  def create

  end

  def edit

  end

  def update

  end

  private

  def set_historico
    @historico = Historico.find(params[:id])
  end
end
