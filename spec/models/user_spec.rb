require 'spec_helper'

describe User do
  subject {build(:user)}
  describe "validations" do
    it "should have a valid factory" do
      expect(subject).to be_valid
    end
  end
  describe "#admin?" do
    context "when they have the admin boolean set" do
      subject {build(:user, :admin => true)}
      it "should be true" do
        expect(subject).to be_admin
      end
    end
    context "when they don't have the admin boolean set" do
      it "should be false" do
        expect(subject).not_to be_admin
      end
    end
  end
end
