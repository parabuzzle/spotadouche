# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_douche_session',
  :secret      => '278624322fdecdd029b656d0db8169e3b5518c5a1e16a7b9f017617b0f3224fa75349c60b52eca937c097c569126bcf1f5f0fd3a0b70f335eb1f5ec638a5d583'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
