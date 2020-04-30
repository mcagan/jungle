module SalesHelper
  def active_sale?
    Sale.active.any?
    true
  end
end