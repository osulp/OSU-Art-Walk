require 'spec_helper'

describe Artist do

  context "relations" do
    it{should have_many(:art_pieces)}
  end
end
