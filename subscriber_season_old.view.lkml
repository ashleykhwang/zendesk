view: subscriber_season_old {
  sql_table_name: public.subscriber_season ;;

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: acquistion_type {
    type: string
    sql: ${TABLE}.acquistion_type ;;
  }

  dimension_group: activation {
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
    sql: ${TABLE}.activation_date ;;
  }

  dimension: activation_season {
    type: string
    sql: ${TABLE}.activation_season ;;
  }

  dimension: addon_eligible {
    type: number
    sql: ${TABLE}.addon_eligible ;;
  }

  dimension: addon_participation {
    type: number
    sql: ${TABLE}.addon_participation ;;
  }

  dimension: box_participation {
    type: number
    sql: ${TABLE}.box_participation ;;
  }

  dimension: box_participation_previous {
    type: number
    sql: ${TABLE}.box_participation_previous ;;
  }

  dimension: box_refund_flag {
    type: number
    sql: ${TABLE}.box_refund_flag ;;
  }

  dimension_group: canceled {
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
    sql: ${TABLE}.canceled_at ;;
  }

  dimension: canceled_flag {
    type: number
    sql: ${TABLE}.canceled_flag ;;
  }

  dimension: choice_participation {
    type: number
    sql: ${TABLE}.choice_participation ;;
  }

  dimension: current_plan_code {
    type: string
    sql: ${TABLE}.current_plan_code ;;
  }

  dimension: downgrade_flag {
    type: number
    sql: ${TABLE}.downgrade_flag ;;
  }

  dimension: edit_sale_eligible {
    type: number
    sql: ${TABLE}.edit_sale_eligible ;;
  }

  dimension_group: expires {
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
    sql: ${TABLE}.expires_at ;;
  }

  dimension: member_status {
    type: string
    sql: ${TABLE}.member_status ;;
  }

  dimension: previous_plan_code {
    type: string
    sql: ${TABLE}.previous_plan_code ;;
  }

  dimension: reactivation_flag {
    type: number
    sql: ${TABLE}.reactivation_flag ;;
  }

  dimension: rebill_1_attempt {
    type: number
    sql: ${TABLE}.rebill_1_attempt ;;
  }

  dimension: rebill_1_success {
    type: number
    sql: ${TABLE}.rebill_1_success ;;
  }

  dimension: rebill_2_attempt {
    type: number
    sql: ${TABLE}.rebill_2_attempt ;;
  }

  dimension: rebill_2_success {
    type: number
    sql: ${TABLE}.rebill_2_success ;;
  }

  dimension: rebill_3_attempt {
    type: number
    sql: ${TABLE}.rebill_3_attempt ;;
  }

  dimension: rebill_3_success {
    type: number
    sql: ${TABLE}.rebill_3_success ;;
  }

  dimension: sale_season {
    type: string
    sql: ${TABLE}.sale_season ;;
  }

  dimension: same_day_cancel_flag {
    type: number
    sql: ${TABLE}.same_day_cancel_flag ;;
  }

  dimension: season_number {
    type: number
    sql: ${TABLE}.season_number ;;
  }

  dimension: set_to_receive_box_flag {
    type: number
    sql: ${TABLE}.set_to_receive_box_flag ;;
  }

  dimension: upgrade_flag {
    type: number
    sql: ${TABLE}.upgrade_flag ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
