require 'spec_helper'

describe ArtPieces do
  subject {build(:art_piece)}

  describe "Validations" do

    context "Presence check" do
      it {should validate_presence_of(:title)}
    end

    context "Type check" do

    end
  end
end
