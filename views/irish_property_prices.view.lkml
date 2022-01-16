view: irish_property_prices {
  sql_table_name: `daveward_demodataset.irish_property_price`
    ;;

  dimension: address {
    type: string
    sql: ${TABLE}.Address ;;
  }

  dimension: address_line_1 {
    type: string
    sql: ${TABLE}.Address_line_1 ;;
  }

  dimension: address_line_2 {
    type: string
    sql: ${TABLE}.Address_line_2 ;;
  }

  dimension: address_line_3 {

    type: string
    sql: ${TABLE}.Address_line_3 ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.County ;;
  }

  dimension_group: date_of_sale {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Date_of_Sale__dd_mm_yyyy_ ;;
  }

  dimension: description_of_property {
    type: string
    sql: ${TABLE}.Description_of_Property ;;
  }

  dimension: not_full_market_price {
    type: yesno
    sql: ${TABLE}.Not_Full_Market_Price ;;
  }

  dimension: postal_code {
    type: string
    sql: ${TABLE}.Postal_Code ;;
  }

  dimension: price {
    hidden: yes
    type: number
    sql: ${TABLE}.Price______ ;;
  }

  dimension: property_size_description {
    type: string
    sql: ${TABLE}.Property_Size_Description ;;
  }

  dimension: vat_exclusive {
    type: yesno
    sql: ${TABLE}.VAT_Exclusive ;;
  }

  measure: count {
    type: count
    drill_fields: [details*]
  }

  measure: total_price {
    type: sum
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
  }

  measure: average_price {
    type: average
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
  }

  dimension: is_this_year {
    type: yesno
    sql: ${date_of_sale_year} =  EXTRACT(YEAR FROM CURRENT_DATE) ;;
  }

  dimension: is_last_year {
    type: yesno
    sql:  ${date_of_sale_year} =  EXTRACT(YEAR FROM CURRENT_DATE)-1 ;;
  }

  dimension: is_included {
    type: yesno
    sql: ${price} < 2000000 and not_full_market_price =  "No" ;;
  }

  measure: average_price_last_year {
    type: average
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
    filters: [is_last_year: "Yes", is_included: "No"]
  }

  measure: average_price_this_year {
    type: average
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
    filters: [is_this_year: "Yes", is_included: "No"]
  }

  measure: total_price_last_year {
    type: sum
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
    filters: [is_last_year: "Yes", is_included: "No"]
  }

  measure: total_price_this_year {
    type: sum
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
    filters: [is_this_year: "Yes", is_included: "No"]
  }

  measure: count_sales_last_year {
    type: count
    drill_fields: [details*]
    filters: [is_last_year: "Yes", is_included: "No"]
  }

  measure: count_sales_this_year {
    type: count
    drill_fields: [details*]
    filters: [is_this_year: "Yes", is_included: "No"]
  }

  measure: max_sales_last_year {
    type: max
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
    filters: [is_last_year: "Yes", is_included: "No"]
  }

  measure: max_sales_this_year {
    type: max
    sql: ${price} ;;
    value_format_name: eur_0
    drill_fields: [details*]
    filters: [is_this_year: "Yes", is_included: "No"]
  }



  measure: count_county {
    type: count_distinct
    sql: ${county} ;;
    value_format_name: decimal_0
  }

  measure: count_address_line_1 {
  type: count_distinct
  sql: ${address_line_1} ;;
  }
  set: details {
    fields: [address_line_1,address_line_2,address_line_3,county,description_of_property,property_size_description,total_price]
  }

}
