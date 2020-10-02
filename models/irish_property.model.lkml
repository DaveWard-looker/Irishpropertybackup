connection: "bigquery_personal_instance"

# include all the views
include: "/views/**/*.view"

datagroup: irish_property_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: irish_property_default_datagroup

explore: irish_property_prices {}
