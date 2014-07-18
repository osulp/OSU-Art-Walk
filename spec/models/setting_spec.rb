require 'spec_helper'

describe Setting do
  it {should validate_presence_of(:setting_name) }
  it {should validate_uniqueness_of(:setting_name) }

  describe "#create_defaults" do

    context "when there are no default setting names present" do
      before do
        Setting.create_defaults
      end
      Setting.default_settings.each do |setting|
        it "should create the default #{setting} setting" do
          expect(Setting.where(:setting_name => setting).count).to eq 1
        end
      end
    end
  end

  describe "setting accessors" do
    let(:setting) {"bla"}
    before do
      Setting.stub(:default_settings).and_return({
          setting => {
            "tag_attributes" => {
              "type" => "email"
            }
          }
        })
    end
    context "when a field is accessed" do
      subject {Setting.send(setting)}
      context "and there is no database entry" do
        it "should return a blank string" do
          expect(subject).to eq ""
        end
      end
      context "and there is a database entry" do
        before do
          create(:setting, :setting_name => setting, :value => "test@test.org")
        end
        it "should return that value" do
          expect(Setting.send(setting)).to eq "test@test.org"
        end
      end
      context "and it's two words" do
        let(:setting) {"Account Name"}
        before do
          create(:setting, :setting_name => "Account Name", :value => "BAH")
        end
        it "should work" do
          expect(Setting.account_name).to eq "BAH"
        end
      end
    end
  end
end
