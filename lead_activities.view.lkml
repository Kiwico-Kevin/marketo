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

  dimension: activity_type {
    sql:
      CASE
        WHEN ${activity_type_id} = '12' THEN '7. New Lead'
        WHEN ${activity_type_id} = '10' THEN '4. Open Email'
        WHEN ${activity_type_id} = '8' THEN '3. Email Bounced'
        WHEN ${activity_type_id} = '9' THEN '6. Unsubscribe Email'
        WHEN ${activity_type_id} = '6' THEN '1. Send Email'
        WHEN ${activity_type_id} = '7' THEN '2. Email Delivered'
        WHEN ${activity_type_id} = '11' THEN '5. Click Email'
        ELSE 'Other'
    END;;
  }

  dimension: primary_attribute_store {
    sql:
      CASE
        WHEN ${primary_attribute_value} LIKE '%cricket%' THEN 'Cricket'
        WHEN ${primary_attribute_value} LIKE '%koala%' THEN 'Koala'
        WHEN ${primary_attribute_value} LIKE '%kiwi%' THEN 'Kiwi'
        WHEN ${primary_attribute_value} LIKE '%doodle%' THEN 'Doodle'
        WHEN ${primary_attribute_value} LIKE '%tinker%' THEN 'Tinker'
        ELSE 'Other'
    END;;
  }

  dimension: primary_attribute_type {
    sql:
      CASE
        WHEN ${primary_attribute_value} LIKE 'Survey Email.%' THEN 'Crate Survey'
        WHEN ${primary_attribute_value} LIKE '%Weekend Activities%' OR ${primary_attribute_value} LIKE '%Midweek Activities%' THEN 'DIY Email'
        WHEN ${primary_attribute_value} LIKE '%Welcome%' AND ${primary_attribute_value} LIKE '%40%' THEN 'Welcome Series - 40%'
        WHEN ${primary_attribute_value} LIKE '%Welcome%' AND ${primary_attribute_value} LIKE '%50%' THEN 'Welcome Series - 50%'
        WHEN ${primary_attribute_value} LIKE '%Welcome%' AND ${primary_attribute_value} LIKE '%60%' THEN 'Welcome Series - 60%'
        WHEN ${primary_attribute_value} LIKE '%Welcome%' AND ${primary_attribute_value} LIKE '%free trial%' THEN 'Welcome Series - free trial'
        WHEN ${primary_attribute_value} LIKE '%Welcome%' THEN 'Welcome Series - 30%'
        WHEN ${primary_attribute_value} LIKE 'Abandoned Cart.%' THEN 'Abandoned Cart'
        WHEN ${primary_attribute_value} LIKE 'Renew Subscription Emails.%' THEN 'Renew Email'
        WHEN ${primary_attribute_value} LIKE 'Sneak Peek Emails.%' THEN 'Sneak Peek'
        ELSE 'Other'
    END;;
  }

  dimension: email_series_number{
    sql:
      CASE
        WHEN ${primary_attribute_value} LIKE '%.1.%' OR ${primary_attribute_value} LIKE '%EM 1%' THEN '1st Email'
        WHEN ${primary_attribute_value} LIKE '%.2.%' OR ${primary_attribute_value} LIKE '%EM 2%' THEN '2nd Email'
        WHEN ${primary_attribute_value} LIKE '%.3.%' OR ${primary_attribute_value} LIKE '%EM 3%' THEN '3rd Email'
        WHEN ${primary_attribute_value} LIKE '%.4.%' OR ${primary_attribute_value} LIKE '%EM 4%' THEN '4th Email'
        ELSE 'Other'
    END;;
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

  measure: distinct_email {
    type: count_distinct
    sql: ${lead_id} ;;
    drill_fields: [id, leads.last_name, leads.id, leads.first_name]
  }
}
