view: lead_activities {
  sql_table_name: marketo.lead_activities ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension_group: activity {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.activity_date ;;
  }

  dimension: activity_type_id {
    type: string
    sql: ${TABLE}.activity_type_id ;;
  }

  dimension: lead_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.lead_id ;;
  }

  dimension_group: loaded {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.loaded_at ;;
  }

  dimension: primary_attribute_value {
    type: string
    sql: ${TABLE}.primary_attribute_value ;;
  }

  dimension: primary_attribute_value_id {
    type: string
    sql: ${TABLE}.primary_attribute_value_id ;;
  }

  dimension_group: received {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.received_at ;;
  }

  dimension_group: uuid_ts {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.uuid_ts ;;
  }

  measure: count {
    type: count
    drill_fields: [id, leads.last_name, leads.id, leads.first_name]
  }
}
