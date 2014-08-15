class ArtPieceDecorator < Draper::Decorator
  delegate_all

  def panel_class
    return "panel-default" if displayed?
    "panel-danger"
  end

  def display_status
    return I18n.t('art_piece.on_display_string') if displayed?
    I18n.t('art_piece.not_on_display_string')
  end

end
