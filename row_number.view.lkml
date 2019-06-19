view: key_num {
  derived_table: {
    sql: SELECT DISTINCT month as row_num FROM dw_dim_dates WHERE MONTH <= 10
      order by 1 asc
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: row_num {
    type: number
    hidden: yes
    sql: ${TABLE}.row_num ;;
  }

  set: detail {
    fields: [row_num]
  }
}
