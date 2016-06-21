# PgSearch.multisearch_options = {
#   :using => [:tsearch, :trigram],
#   :ignoring => :accents
# }
PgSearch.multisearch_options = {
  :using => { :tsearch => 
              { :prefix => true}
  }
}
