view: save_type_tactics {
  derived_table: {
    sql: WITH zendesk_save_starting_cohort AS
      (
        SELECT DISTINCT zendesk.users.email AS account_code,
               public.dw_dim_dates.regular_season AS ticket_solved_season,
               s.season_number,
               zendesk.tickets.cancel_result AS save_type_tactic,
               s.member_status AS status_0
        FROM zendesk.tickets
          JOIN zendesk.users ON zendesk.tickets.requester_id = zendesk.users.id
          JOIN zendesk.ticket_metrics ON zendesk.tickets.id = zendesk.ticket_metrics.ticket_id
          JOIN dw_dim_dates ON TRUNC (zendesk.ticket_metrics.solved_at) = public.dw_dim_dates.day
          LEFT JOIN subscriber_season s
                 ON zendesk.users.email = s.account_code
                AND public.dw_dim_dates.regular_season = s.sale_season
        WHERE /*TRUNC(zendesk.ticket_metrics.solved_at) >= '2018-01-01'
        AND */
        {% condition solved_at %} TRUNC(zendesk.ticket_metrics.solved_at) {% endcondition %}
       and  zendesk.tickets.cancel_result IN ('save__other','save__select','save__change_bill_date','save__discount','save__ship_date','save__free_product','save__education','save__skip')
        AND   zendesk.users.email IS NOT NULL
        AND   s.member_status = 'Active'
      )
      SELECT z.account_code,
             z.ticket_solved_season,
             z.season_number,
             s1.season_number as sales_season_number,
             z.save_type_tactic,
             s1.member_status
      FROM zendesk_save_starting_cohort z
        LEFT JOIN subscriber_season s1 ON s1.account_code = z.account_code
      WHERE z.season_number <= s1.season_number
       ;;
  }

  filter: solved_at {
    type: date
    }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_active {
    type: count
    filters: {
      field: member_status
      value: "Active"
    }
  }

  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: ticket_solved_season {
    type: string
    sql: ${TABLE}.ticket_solved_season ;;
  }

  dimension: season_number {
    type: number
    sql: ${TABLE}.season_number ;;
  }

  dimension: sales_season_number {
    type: number
    sql: ${TABLE}.sales_season_number ;;
  }

  dimension: save_type_tactic {
    type: string
    sql: ${TABLE}.save_type_tactic ;;
  }

  dimension: member_status {
    type: string
    sql: ${TABLE}.member_status ;;
  }

  set: detail {
    fields: [
      account_code,
      ticket_solved_season,
      season_number,
      sales_season_number,
      save_type_tactic,
      member_status
    ]
  }
}
