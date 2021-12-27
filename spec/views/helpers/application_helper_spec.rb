require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe "#full_title(page_title)" do
    subject { full_title(page_title) }

    context "page_titleの値がnilの場合" do
      let(:page_title) { nil }

      example "「BIGBAG Store」を出力すること" do
        is_expected.to eq("BIGBAG Store")
      end
    end

    context "page_titleの値が空白の場合" do
      let(:page_title) { "" }

      example "「BIGBAG Store」を出力すること" do
        is_expected.to eq("BIGBAG Store")
      end
    end

    context "page_titleが文字列で与えられる場合" do
      let(:page_title) { "test_title" }

      example "「test_title - BIGBAG Store」を出力すること" do
        is_expected.to eq("test_title - BIGBAG Store")
      end
    end
  end
end
