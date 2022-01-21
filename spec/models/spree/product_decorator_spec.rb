require 'rails_helper'

RSpec.describe Spree::ProductDecorator, type: :model do
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon]) }
  let!(:related_products) { create_list(:product, 5, taxons: [taxon]) }
  let!(:unrelated_product) { create(:product, taxons: [create(:taxon)]) }
  let(:duplicate_related_products) { related_products.push(related_products.first) }

  it "関連商品が取得されること" do
    related_products.all? { |related_product| expect(product.related_products).to include related_product }
  end

  it "関連しない商品は含まないこと" do
    expect(product.related_products).not_to include unrelated_product
  end

  it "メイン商品が関連商品に含まないこと" do
    expect(product.related_products).not_to include product
  end

  it "各関連商品は一意的であること" do
    expect(product.related_products).to eq duplicate_related_products.uniq
  end
end
