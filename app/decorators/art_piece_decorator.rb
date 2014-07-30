class ArtPieceDecorator < Draper::Decorator
  delegate_all

  def panel_class
    return "panel-primary" if displayed?
    "panel-danger"
  end

end