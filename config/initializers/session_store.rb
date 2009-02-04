# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_thunk_session',
  :secret      => 'c1eef24bf0674d8b1d6f27ccd2ecd5ee7ac2bbd0097482f355800a2951038065e21668e91aaeb529fdfdbd7920517abed27d97b8a8d84a92969a888921aa20d6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
