require 'spec_helper'

describe Setting do
  it {should validate_presence_of(:setting_name) }
  it {should validate_uniqueness_of(:setting_name) }

  describe "#create_defaults" do

    context "when there are no default setting names present" do
      before do
        Setting.create_defaults
      end
      it "should create the defaults with their setting_names" do
        expect(Setting.count).to eq 3
      end
    end
  end
end
