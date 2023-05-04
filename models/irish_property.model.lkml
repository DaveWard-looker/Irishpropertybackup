connection: "bigquery_personal_instance"

# include all the views
include: "/views/**/*.view"

datagroup: irish_property_default_datagroup {
  max_cache_age: "1 hour"
}

# a test comment

persist_with: irish_property_default_datagroup


explore: irish_property_prices {
  description: "This explore if for Irish Property Prices only within Dublin"
conditionally_filter: {
  filters: [irish_property_prices.county: "Dublin"]
  unless: [address]
}
}
