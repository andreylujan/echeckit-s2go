class TokenResource < JSONAPI::Resource
    attributes :access_token,
    :token_type,
    :expires_in,
    :refresh_token,
    :scope,
    :created_at
end
