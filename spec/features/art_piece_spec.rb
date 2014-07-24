require 'spec_helper'

describe "Art Piece Manipulation" do
  let(:user) {}
  let(:art) {build(:art_piece)}

  before do
    capybara_login(user) if user
    visit root_path
  end 

  context "when on the index page" do

    before do
      visit admin_art_pieces_path
    end

    context "and no art pieces are present" do
      let(:user) {create(:user, :admin)}
      it "should display No Art Pieces Currently In The Database" do
       expect(page).to have_content("No Art Pieces Currently In The Database")
      end
    end

    context "and art pieces are present" do
      let(:user) {create(:user, :admin)}
      before do
        art
        art.save
        visit admin_art_pieces_path
      end
      it "should show the saved art piece" do
        expect(page).to have_content(art.title)
      end

      it "should have the name as a link to collapse the boxes" do
        within "#piece-#{art.id}" do
          click_link "#{art.title}"
        end
        expect(page).to have_content("#{art.medium}")
      end

      it "should have links to edit and delete each art piece" do
        within "#piece-#{art.id}" do
          expect(page).to have_link "Edit"
          expect(page).to have_link "Delete"
        end
      end
      it "should take you to the edit page" do
        within "#piece-#{art.id}" do
          click_link "Edit"
        end
        expect(page).to have_content("Edit")
      end

      it "should delete the art piece" do
        within "#piece-#{art.id}" do
          click_link "Delete"
        end
        expect(page).to_not have_selector("#piece-#{art.id}")
      end
      context "and buildings are updated" do
        let(:building) { create(:building) }

        before do
          art.building = building
          art.save
          visit edit_admin_building_path(art.building)
          fill_in "Lat", :with => 40.000
          click_button "Update Building"
        end

        it "should update the info of building associated with art piece" do
          expect(art.building[:lat]).to eq BigDecimal('40.000')
        end
      end
    end
  end

  context "When editing an art piece" do
    before do
      visit admin_art_pieces_path
    end

    context "and art pieces are present" do
      let(:user) {create(:user, :admin)}
      before do
        art
        art.save
        visit admin_art_pieces_path
        click_link "Edit"
      end
      it "should edit the art piece properly" do
        fill_in "Title", :with => "Example Title 2"
        click_button "Update Art piece"
        expect(page).to have_content("Example Title 2")
        expect(art.reload.title).to eq "Example Title 2"
      end
    end
  end

  context "when adding a new art piece" do
    let(:user) {create(:user, :admin)}
    before do
      visit admin_art_pieces_path
    end
    context "clicking add should bring you to the new art piece page" do
      before do
        click_link "Add Art Piece"
      end

      context "when removing the photo field" do
        it "should let you fill in the forms and save the new art piece", :js => true do
          fill_in "Title", :with => "Cool Title"
          click_link "remove"
          click_button "Create Art piece"
          expect(page).to have_content("Cool Title")
          expect(ArtPiece.first.title).to eq "Cool Title"
        end
      end
      context "when adding an art piece with a blank photo field" do
        before do
          fill_in "Title", :with => "Cool Title"
          click_button "Create Art piece"
        end
        it "should cause an error to occur" do
          within(".help-block") do
            expect(page).to have_content("can't be blank")
          end
        end
      end

    end

  end
end
