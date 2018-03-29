view: ticket_stats_by_organization {
  derived_table: {
    sql: SELECT
        organizations.name  AS "organizations.name",
        COUNT(DISTINCT CASE WHEN tickets.status = 'new'  THEN tickets.id  ELSE NULL END) AS "tickets.count_new_tickets",
        COUNT(DISTINCT CASE WHEN tickets.status = 'open'  THEN tickets.id  ELSE NULL END) AS "tickets.count_open_tickets",
        COUNT(DISTINCT CASE WHEN tickets.status = 'solved' OR tickets.status = 'closed'  THEN tickets.id  ELSE NULL END) AS "tickets.count_solved_tickets",
        COUNT(DISTINCT tickets.id ) AS "tickets.count",
        AVG((ticket_metrics.full_resolution_time_in_minutes_business / 480) ) AS "ticket_metrics.avg_full_resolution_time_in_days__business"
      FROM zendesk.ticket_metrics  AS ticket_metrics
      LEFT JOIN zendesk.tickets  AS tickets ON ticket_metrics.ticket_id = tickets.id
      LEFT JOIN zendesk.organizations  AS organizations ON tickets.organization_id = organizations.id

      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: organizations_name {
    type: string
    sql: ${TABLE}."organizations.name" ;;
  }

  dimension: tickets_count_new_tickets {
    type: number
    sql: ${TABLE}."tickets.count_new_tickets" ;;
  }

  dimension: tickets_count_open_tickets {
    type: number
    sql: ${TABLE}."tickets.count_open_tickets" ;;
  }

  dimension: tickets_count_solved_tickets {
    type: number
    sql: ${TABLE}."tickets.count_solved_tickets" ;;
  }

  dimension: tickets_count {
    type: number
    sql: ${TABLE}."tickets.count" ;;
  }

  dimension: ticket_metrics_avg_full_resolution_time_in_days__business {
    type: number
    sql: ${TABLE}."ticket_metrics.avg_full_resolution_time_in_days__business" ;;
  }

  set: detail {
    fields: [
      organizations_name,
      tickets_count_new_tickets,
      tickets_count_open_tickets,
      tickets_count_solved_tickets,
      tickets_count,
      ticket_metrics_avg_full_resolution_time_in_days__business
    ]
  }
}
