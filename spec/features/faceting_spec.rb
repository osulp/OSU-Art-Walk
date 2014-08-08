require 'spec_helper'

describe "faceting" do

  before do
    subject
    visit root_path
  end

  context "when there is an art piece" do
    subject {create(:art_piece)}
    context "with a building" do
      subject {create(:art_piece, :with_building)}
      it "should have a link for that building" do
        expect(page).to have_link subject.building.name
      end
      context "and the facet is clicked" do
        before do
          click_link subject.building.name
          click_link "List"
        end
        it "should show the title for the art piece" do
          within(".document .index_title") do
            expect(page).to have_content(subject.title)
          end
        end
        context "and there is an unrelated art piece" do
          subject do
            art_piece_2
            create(:art_piece, :with_building)
          end
          before do
            click_link "List"
          end
          let(:art_piece_2) {create(:art_piece)}
          it "should not show it" do
            expect(page).not_to have_content art_piece_2.title
            expect(page).to have_selector(".document", :count => 1)
          end
        end
      end

    end
    context "with an artist" do
      subject {create(:art_piece, :with_artist)}
      it "should have a link for that artist" do
        expect(page).to have_link subject.artists.name
      end
    end
    context "with a featured artist" do
      let(:art_piece) {create(:art_piece, :with_building, :with_artist)}

      before do
        art_piece.artists.first.featured = true
        art_piece.save
        visit root_path
      end

      it "should have a featured artist facet" do
        expect(page).to have_link("Featured Artists")
      end
    end
    context "with a collection" do
      subject {create(:art_piece, :with_collection)}
      it "should have a link for that artist" do
        expect(page).to have_link subject.collections.name
      end
    end
    context "with a status" do
      context "of student" do
        subject {create(:art_piece, :with_student)}
        it "should have a link for that status" do
          expect(page).to have_link("Created by Student")
        end
      end
      context "of faculty" do
        subject {create(:art_piece, :with_faculty)}
        it "should have a link for that status" do
          expect(page).to have_link("Created by Faculty")
        end
      end
    end
  end
end
