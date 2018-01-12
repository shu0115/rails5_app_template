Rails.application.config.session_store(
  :cookie_store,
  key:          "_#{Settings.app_name.downcase}_session",
  expire_after: 2.weeks,
)
