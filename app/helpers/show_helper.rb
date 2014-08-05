module ShowHelper
  include Blacklight::BlacklightHelperBehavior

  def private_document?(_, document)
    document['private_bs']
  end

  def should_render_show_field? document, solr_field
    document[solr_field.field].present? && super
  end
end