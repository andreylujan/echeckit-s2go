# -*- encoding : utf-8 -*-
# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4 
# requires secret_key_base or secret_token to be defined, otherwise an 
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
EcheckitApi::Application.config.secret_token = '287204f17999210b47364785d8e95814c3baa318753afe364cfda1832c9ca574fd3ee8818f8a87d1a09a7b3abe04bd48ba0ff4cc944f170db89bb7a064c26c43'
