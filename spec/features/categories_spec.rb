require 'rails_helper'

RSpec.feature "Get /potepan/categories/:id", type: :feature do
  let(:taxonomy) { create(:taxonomy, name: "Categories") }
  let(:taxon) { taxonomy.root }
  let(:shirts) { create(:taxon, name: "Shirts", taxonomy: taxonomy, parent: taxon) }
  let(:shirts_product) { create(:product, name: "RUBY POLO", price: "26.99", taxons: [shirts]) }
  let!(:shirts_product_image) { shirts_product.master.images.create!(attachment: create(:image).attachment) }
  let(:hoodie) { create(:taxon, name: "Hoodie", taxonomy: taxonomy, parent: taxon) }
  let(:hoodie_product) { create(:product, name: "SOLIDUS HOODIE ZIP", price: "29.99", taxons: [hoodie]) }
  let!(:hoodie_product_image) { hoodie_product.master.images.create(attachment: create(:image).attachment) }

  background do
    visit potepan_category_path(taxon.id)
  end

  scenario "ページタイトルが表示されること" do
    expect(page).to have_title "#{taxon.name} - BIGBAG Store"
    expect(page).to have_selector ".page-title h2", text: taxon.name
  end

  scenario "商品カテゴリーのテキストが表示されること" do
    expect(page).to have_selector ".panel-body", text: taxonomy.name
    expect(page).to have_selector ".panel-body", text: taxon.name
    expect(page).to have_selector ".panel-body", text: shirts.name
    expect(page).to have_selector ".panel-body", text: hoodie.name
  end

  scenario "商品テキストが表示されること" do
    expect(page).to have_selector ".productCaption h5", text: shirts_product.name
    expect(page).to have_selector ".productCaption h3", text: shirts_product.display_price
    expect(page).to have_selector ".productCaption h5", text: hoodie_product.name
    expect(page).to have_selector ".productCaption h3", text: hoodie_product.display_price
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

  scenario "他カテゴリーへリンクされていること" do
    expect(page).to have_link shirts.name, href: potepan_category_path(shirts.id)
    expect(page).to have_link hoodie.name, href: potepan_category_path(hoodie.id)
  end

  scenario "商品詳細ページへリンクされていること" do
    expect(page).to have_link shirts_product.name, href: potepan_product_path(shirts_product.id)
  end
end
