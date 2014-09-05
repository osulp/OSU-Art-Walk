module FacetHelper
  include Blacklight::BlacklightHelperBehavior

  def admin?(_, document)
    current_user && current_user.admin?
  end
end