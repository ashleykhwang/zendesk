view: zendesk_contact_reason_sub_category {
  derived_table: {
    sql: WITH zendesk_contact_reason_sub_categories AS
      (
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.modify_order AS sub_category,
               'modify_order' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.shipping,
               'shipping' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.cancel_result,
               'cancel_result' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.billing,
               'billing' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.fulfillment_issue,
               'fulfillment_issue' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.info_requested,
               'info_requested' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.tech_issue,
               'tech_issue' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.product_related,
               'product_related' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.order_customize_edit,
               'order_customize_edit' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.other,
               'other' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
        UNION
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) as solved_ticket_at,
               t.contact_reason,
               t.update,
               'update' AS Category,
               COUNT(*)
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('PST',tm.solved_at) {% endcondition %}
        GROUP BY 1,
                 2,
                 3,
                 4
      )
      SELECT *
      FROM zendesk_contact_reason_sub_categories z
      ORDER BY 1 ASC,
               2 ASC,
               3 ASC,
               4 ASC
       ;;
  }

  dimension: solved_ticket_at {
    label: "solved_ticket_at_pst"
    type: date
    sql: ${TABLE}.solved_ticket_at ;;
  }

  dimension: contact_reason {
    type: string
    sql: ${TABLE}.contact_reason ;;
  }

  dimension: sub_category {
    type: string
    sql: ${TABLE}.sub_category ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
  }

  measure: total_ticket_solved{
    type: count
    drill_fields: [detail*]
  }

  filter: solved_at {
    type: date
  }

  set: detail {
    fields: [solved_ticket_at, contact_reason, sub_category, category, count]
  }
}
