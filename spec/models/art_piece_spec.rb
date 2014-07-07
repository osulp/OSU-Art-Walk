require 'spec_helper'

describe ArtPiece do
  subject {build(:art_piece)}

  describe "Validations" do

    context "Presence check" do
      it {should validate_presence_of(:title)}
    end
  end
end
