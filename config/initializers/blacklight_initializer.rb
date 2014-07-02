# A secret token used to encrypt user_id's in the Bookmarks#export callback URL
# functionality, for example in Refworks export of Bookmarks. In Rails 4, Blacklight
# will use the application's secret key base instead.
#

Blacklight.secret_key = ENV['blacklight_key'] || '66d69df27a74022198c0335d1b2b21c81c45b09aaab30aa31f0c2cfcd8422ab7addc56b6a2065871621abae71647bc891fb428a54fbbd81bb975c5afacd9bdf4'

