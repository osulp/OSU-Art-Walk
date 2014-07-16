require "spec_helper"

describe "settings" do
  let(:user) {}
  let(:setting) {create(:setting)}

  before do
    capybara_login(user) if user
    visit root_path
  end
  
  context "when on the admin page" do
    let(:user) {create(:user, :admin)}
    before do
      visit admin_index_path
      click_link "Settings"
    end
    it "should go to the settings page" do
      expect(page).to have_content("Settings Page")
    end
    context "when on the index page" do
      let(:user) {create(:user, :admin)}
      before do
        visit admin_settings_path
      end
      it "should display the settings page" do
        expect(page).to have_content("Settings Page")
      end
      it "should display the add settings button" do
        expect(page).to have_content("Add Settings")
      end
      context "when there are settings entered" do
        before do
          setting
          visit admin_settings_path
        end
        it "should display the settings information" do
          expect(page).to have_content("#{setting.copyright}")
        end
        it "should display the delete setting link" do
          expect(page).to have_content("Delete")
        end
        context "when deleting a setting" do
          before do
            click_link "Delete"
          end
          it "should delete the setting" do
            expect(Setting.count).to eq 0
          end
        end
        it "should display the edit settings link" do
          expect(page).to have_content("Edit")
        end
        context "when editing the setting" do
          before do
            click_link "Edit"
          end
          it "should display the setting information" do
            expect(page).to have_field("Copyright", :with => setting.copyright)
            expect(page).to have_field("Email", :with => setting.email)
            expect(page).to have_field("About", :with => setting.about)
          end
          context "when updating the setting information" do
            before do
              fill_in "Copyright", :with => "updated copyright is DO NOT steal. Please."
              fill_in "Email", :with => "testemail2@oregonstate.edu"
              fill_in "About", :with => "updated about info"
              click_button "Update Setting"
            end
            it "should update and display the settings" do
              expect(page).to have_content("updated copyright is DO NOT steal. Please.")
              expect(page).to have_content("testemail2@oregonstate.edu")
              expect(page).to have_content("updated about info")
            end
          end
        end
      end
      context "when there are no settings entered" do
        it "should display that there are no settings entered" do
          expect(page).to have_content("There are no settings entered. Please add settings.")
        end
        context "when adding settings" do
          before do
            click_link "Add Settings"
          end
          it "should display the add settings page" do
            expect(page).to have_content("Add Settings Page")
            expect(page).to have_field("Copyright")
            expect(page).to have_field("Email")
            expect(page).to have_field("About")
          end
          context "when creating the setting" do
            before do
              fill_in "Copyright", :with => "Test Copyright information is please do not steal"
              fill_in "Email", :with => "testemail1@oregonstate.edu"
              fill_in "About", :with => "testing about page"
              click_button "Create Setting"
            end
            it "should display the newly created setting info" do
              expect(page).to have_content("Test Copyright information is please do not steal")
              expect(page).to have_content("testemail1@oregonstate.edu")
              expect(page).to have_content("testing about page")
            end
          end
        end
      end
    end
  end
end
