JSONAPI.configure do |config|
  # built in key format options are :underscored_key, :camelized_key and :dasherized_key
  config.json_key_format = :underscored_key
  config.default_paginator = :paged

  config.default_page_size = 10
  config.maximum_page_size = 30
end