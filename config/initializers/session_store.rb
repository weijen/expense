# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_expense_session',
  :secret      => '63de265d7fcd14ee067cdfc615505d6debe1a7c79f75d646b3ab07cf8e1a86631e40614b5dd4afb76de3197b62d0dfc710aabafb5a08a273f2b693c994b3a9e7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
