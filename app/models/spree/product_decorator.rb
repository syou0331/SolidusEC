module Spree::ProductDecorator
  def related_products(display_limit)
    Spree::Product.
      in_taxons(taxons).
      where.not(id: id).
      distinct.
      limit(display_limit)
  end
  Spree::Product.prepend self
end
