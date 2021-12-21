require 'rails_helper'

RSpec.describe "Potepan::ProductsController", type: :request do
  describe "GET /potepan/products/:id(商品詳細ページ)" do
    let(:product) { create(:product) }

    before do
      get potepan_product_url(id: product.id)
    end

    example "レスポンスを返すこと" do
      expect(response).to have_http_status(:success)
    end

    example "プロダクトとテストの「@product」が一致すること" do
      expect(controller.instance_variable_get("@product")).to eq product
    end
  end
end
