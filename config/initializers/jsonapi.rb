JSONAPI.configure do |config|
  # built in key format options are :underscored_key, :camelized_key and :dasherized_key
  config.json_key_format = :underscored_key
  config.default_paginator = :paged

  config.default_page_size = 99999
  config.maximum_page_size = 99999

  config.top_level_links_include_pagination = false
  config.always_include_to_one_linkage_data = false
end