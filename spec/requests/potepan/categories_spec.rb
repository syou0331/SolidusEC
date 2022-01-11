require 'rails_helper'

RSpec.describe "Potepan::CategoriesController", type: :request do
  describe "GET /potepan/categories/:id" do
    let(:taxon) { create(:taxon) }

    before do
      get potepan_category_path(taxon.id)
    end

    example "HTTPのステータスコードが200であること" do
      expect(response).to have_http_status(:success)
    end

    example "@taxonとtaxonが一致すること" do
      expect(controller.instance_variable_get("@taxon")).to eq taxon
    end
  end
end
