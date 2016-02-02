Rails.configuration.stripe = {
  publishable_key: Rails.application.secrets.stripe_publishable_key,
  secret_key:      Rails.application.secrets.stripe_secret_key
}

# Rails.configuration.stripe = {
#   publishable_key: "pk_test_OGDwO3uYN9OLBPdoaPRL9KZS",
#   secret_key:      "sk_test_F0a6YbfXKFWFeP9M7uPLtB40"

Stripe.api_key = Rails.application.secrets.stripe_secret_key
