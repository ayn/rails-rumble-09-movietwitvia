# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rr_session',
  :secret      => 'e364df10ceb04bef554e808b2ba609cc2f53bce9ad09b99b80d3e28b2a02528e8c00e3deccc42d21914c1670bb7bb312a5c87a61a140be7f417ab1731428c4ae'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
