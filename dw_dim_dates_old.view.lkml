view: dw_dim_dates {
  sql_table_name: public.dw_dim_dates ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: addon {
    type: string
    sql: ${TABLE}.addon ;;
  }

  dimension: bank_holiday {
    type: string
    sql: ${TABLE}.bank_holiday ;;
  }

  dimension: crm_events {
    type: string
    sql: ${TABLE}.crm_events ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date_time ;;
  }

  dimension_group: day {
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
    sql: ${TABLE}.day ;;
  }

  dimension: dayofweek {
    type: number
    sql: ${TABLE}.dayofweek ;;
  }

  dimension: edit_sale {
    type: string
    sql: ${TABLE}.edit_sale ;;
  }

  dimension: editors_box {
    type: string
    sql: ${TABLE}.editors_box ;;
  }

  dimension: is_weekend {
    type: string
    sql: ${TABLE}.is_weekend ;;
  }

  dimension: marketing_events {
    type: string
    sql: ${TABLE}.marketing_events ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension: nm_addon {
    type: number
    sql: ${TABLE}.nm_addon ;;
  }

  dimension: normal_addon {
    type: string
    sql: ${TABLE}.normal_addon ;;
  }

  dimension: priority_addon {
    type: string
    sql: ${TABLE}.priority_addon ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}.quarter ;;
  }

  dimension: rebill {
    type: number
    sql: ${TABLE}.rebill ;;
  }

  dimension: regular_season {
    type: string
    sql: ${TABLE}.regular_season ;;
  }

  dimension: season_end {
    type: number
    sql: ${TABLE}.season_end ;;
  }

  dimension: season_number {
    type: number
    sql: ${TABLE}.season_number ;;
  }

  dimension: season_start {
    type: number
    sql: ${TABLE}.season_start ;;
  }

  dimension: select_addon {
    type: string
    sql: ${TABLE}.select_addon ;;
  }

  dimension_group: week {
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
    sql: ${TABLE}.week ;;
  }

  dimension: week1 {
    type: number
    sql: ${TABLE}.week1 ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
