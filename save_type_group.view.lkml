view: save_type_group {
  # parameter: received_season {
   #  type: date
  #}
  derived_table: {
    sql: WITH zendesk_save_starting_cohort AS
      (
        SELECT DISTINCT zendesk.users.email AS account_code,
               public.dw_dim_dates.regular_season AS ticket_received_season,
               s.season_number,
               CASE
                 WHEN zendesk.tickets.contact_reason = 'cancel_request__at_renew' AND zendesk.tickets.cancel_result = 'save__skip' THEN 'skip_a_season_offered'
                 WHEN (zendesk.tickets.contact_reason = 'order_customize_edit' AND zendesk.tickets.modify_order = 'skip_a_season') OR (zendesk.tickets.contact_reason = 'order_customize_edit' AND zendesk.tickets.order_customize_edit = 'skip_a_season') THEN 'skip_a_season_on_their_own'
                 ELSE 'OTHER'
               END AS zendesk_ticket_save_type_group,
               s.member_status AS status_0
        FROM zendesk.tickets
          JOIN zendesk.users ON zendesk.tickets.requester_id = zendesk.users.id
          JOIN zendesk.ticket_metrics ON zendesk.tickets.id =zendesk.ticket_metrics.ticket_id
          JOIN dw_dim_dates ON trunc(zendesk.ticket_metrics.solved_at) = public.dw_dim_dates.day
          JOIN subscriber_season s
            ON zendesk.users.email = s.account_code
           AND public.dw_dim_dates.regular_season = s.sale_season
        WHERE /*public.dw_dim_dates.regular_season IN ({% parameter received_season %})*/
        {% condition received_season %} public.dw_dim_dates.regular_season {% endcondition %}
        AND   ((zendesk.tickets.contact_reason = 'cancel_request__at_renew' AND zendesk.tickets.cancel_result = 'save__skip') OR (zendesk.tickets.contact_reason = 'order_customize_edit' AND zendesk.tickets.modify_order = 'skip_a_season')
         OR (zendesk.tickets.contact_reason = 'order_customize_edit' AND zendesk.tickets.order_customize_edit = 'skip_a_season'))
        AND   zendesk.users.email IS NOT NULL
        AND   s.member_status = 'Active'
      )
      SELECT z.account_code,
             z.ticket_received_season,
             zendesk_ticket_save_type_group,
             z.status_0,
             s1.member_status AS status_1,
             s2.member_status AS status_2,
             s2.member_status AS status_3,
             s2.member_status AS status_4
      FROM zendesk_save_starting_cohort z
        LEFT JOIN subscriber_season s1
               ON s1.account_code = z.account_code
              AND s1.season_number = z.season_number +1
        LEFT JOIN subscriber_season s2
               ON s2.account_code = z.account_code
              AND s2.season_number = z.season_number +2
        LEFT JOIN subscriber_season s3
               ON s3.account_code = z.account_code
              AND s3.season_number = z.season_number +3
     order by 1,2,3  ;;
  }

  filter: received_season {
    type: string
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

measure: count_status_1 {
  type:count
  filters:{
    field: status_1
    value: "Active"
          }
 }

  measure: count_status_2 {
    type:count
    filters:{
      field: status_2
      value: "Active"
    }
  }

  measure: count_status_3 {
    type:count
    filters:{
      field: status_3
      value: "Active"
    }
   }

  measure: count_status_4 {
    type:count
    filters:{
      field: status_4
      value: "Active"
    }
  }


  dimension: account_code {
    type: string
    sql: ${TABLE}.account_code ;;
  }

  dimension: ticket_received_season {
    type: string
    sql: ${TABLE}.ticket_received_season ;;
  }

  dimension: zendesk_ticket_save_type_group {
    type: string
    sql: ${TABLE}.zendesk_ticket_save_type_group ;;
  }

  dimension: status_0 {
    type: string
    sql: ${TABLE}.status_0 ;;
  }

  dimension: status_1 {
    type: string
    sql: ${TABLE}.status_1 ;;
  }

  dimension: status_2 {
    type: string
    sql: ${TABLE}.status_2 ;;
  }

  dimension: status_3 {
    type: string
    sql: ${TABLE}.status_3 ;;
  }

  dimension: status_4 {
    type: string
    sql: ${TABLE}.status_4 ;;
  }
  set: detail {
    fields: [
      account_code,
      ticket_received_season,
      zendesk_ticket_save_type_group,
      status_0,
      status_1,
      status_2,
      status_3,
      status_4
    ]
  }
}
