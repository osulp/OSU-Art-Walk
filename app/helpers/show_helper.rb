module ShowHelper
  include Blacklight::BlacklightHelperBehavior

  def private_document?(_, document)
    document['private_bs']
  end
end