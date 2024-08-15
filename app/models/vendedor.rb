class Vendedor < ApplicationRecord
  after_initialize :set_default_values, if: :new_record?

  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :produtos, dependent: :destroy
  accepts_nested_attributes_for :produtos, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
  has_many :reviews

  validates :emailParaContato, presence: true
  validates :totalVendas, numericality: { greater_than_or_equal_to: 0 }
  validates :nota, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  private

  def set_default_values
    self.totalVendas ||= 0
    self.nota ||= 0.0
  end

  def calculate_nota
    if reviews.any?
      somaNotas = reviews.sum(:nota)
      self.nota = somaNotas / reviews.count.to_f
    else
      self.nota = 0
    end
    self.save
  end
end
