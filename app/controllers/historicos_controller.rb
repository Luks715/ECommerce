class HistoricosController < ApplicationController
  before_action :set_historico

  def new
    @historico = Historico.new
  end

  def create

  end

  private

  def set_historico
    @historico = Historico.find(params[:id])
  end
end
