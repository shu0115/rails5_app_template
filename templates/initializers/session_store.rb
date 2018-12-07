Rails.application.config.session_store(
  :cookie_store,
  key:          "_#{Rails.application.class.parent_name.underscore}_session",
  expire_after: 2.weeks,
)
