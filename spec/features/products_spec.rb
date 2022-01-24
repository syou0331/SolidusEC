require 'rails_helper'

RSpec.feature "Get /potepan/products/:id", type: :feature do
  let(:product) { create(:product) }
  let(:image) { create(:image) }
  let(:taxon) { create(:taxon) }
  let(:related_products_list) { create_list(:product, 4, taxons: [taxon]) }

  background do
    product.images << image
    product.taxons << taxon
    related_products_list.each { |related_product| related_product.images << create(:image) }
    visit potepan_product_path(product.id)
  end

  scenario "ページタイトルが表示されること" do
    expect(page).to have_title(product.name + " - " + "BIGBAG Store")
    expect(page).to have_selector ".page-title h2", text: product.name
  end

  scenario "商品テキストが表示されること" do
    expect(page).to have_selector ".media-body h2", text: product.name
    expect(page).to have_selector ".media-body h3", text: product.display_price
    expect(page).to have_selector ".media-body p", text: product.description
  end

  scenario "画像が表示されること" do
    product.images.all? do |img|
      expect(page).to have_selector("img[src$='#{img.attachment_file_name}']")
    end
  end

  scenario "関連商品が4つ分表示されること" do
    expect(page).to have_selector('.productBox', count: 4)
  end

  scenario "「Home」へリンクされていること" do
    within("ol") do
      expect(page).to have_link "Home", href: potepan_path
    end

    within("ul.navbar-right") do
      expect(page).to have_link "Home", href: potepan_path
    end

    within("div.navbar-header") do
      expect(page).to have_link "", href: potepan_path
    end
  end

  scenario "「一覧ページへ戻る」へリンクされていること" do
    expect(page).to have_link "一覧ページへ戻る", href: potepan_category_path(product.taxons.first.id)
  end

  scenario "関連商品が、対応する商品詳細ページへリンクされていること" do
    within(".productsContent") do
      expect(page).to have_link "#{related_products_list.first.name}", href: potepan_product_path(related_products_list.first.id)
    end
  end
end
