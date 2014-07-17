require 'spec_helper'

describe "catalog show" do
  def document_id(model)
    Sunspot::Adapters::InstanceAdapter.adapt(model).index_id
  end
  context "when there's an art piece" do
    let(:art_piece) do
      create(:art_piece)
      create(:art_piece)
    end
    before do
      visit catalog_path(:id => document_id(art_piece)) 
    end
    it "should show the title" do
      expect(page).to have_content(art_piece.title)
    end
  end
end
