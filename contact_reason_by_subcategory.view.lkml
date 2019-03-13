view: contact_reason_by_subcategory {
  derived_table: {
    sql: WITH zendesk_contact_reason_sub_categories AS
      (
        SELECT TRUNC(convert_timezone ('MST',tm.solved_at)) AS solved_ticket_at,
               t.contact_reason,
               t.modify_order,
               t.shipping,
               t.update,
               t.fulfillment_issue,
               t.product_related,
               t.other,
               t.tech_issue,
               t.cancel_result,
               t.info_requested,
               t.order_customize_edit,
               t.billing,
               t.id
        FROM zendesk.ticket_metrics tm
          LEFT JOIN zendesk.tickets t ON t.id = tm.ticket_id
        WHERE  {% condition solved_at %}  convert_timezone('MST',tm.solved_at) {% endcondition %}
      ),
      zendesk_contact_reason_sub_categories_2 AS
      (
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.modify_order AS sub_category,
               'modify_order' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.shipping AS sub_category,
               'shipping' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.cancel_result AS sub_category,
               'cancel_result' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.billing AS sub_category,
               'billing' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.fulfillment_issue AS sub_category,
               'fulfillment_issue' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.info_requested AS sub_category,
               'info_requested' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.tech_issue AS sub_category,
               'tech_issue' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.product_related AS sub_category,
               'product_related' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.order_customize_edit AS sub_category,
               'order_customize_edit' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.other AS sub_category,
               'other' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
        UNION
        SELECT z.solved_ticket_at AS solved_ticket_at,
               z.contact_reason,
               z.update AS sub_category,
               'update' AS Category,
               z.id
        FROM zendesk_contact_reason_sub_categories z
      )
      SELECT DISTINCT zz.solved_ticket_at,
             zz.contact_reason,
             zz.sub_category,
             zz.category,
             zz.id
      FROM zendesk_contact_reason_sub_categories_2 zz

      order  by 1,
               2,
               3,
               4
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_ticket_solved{
    type:count_distinct
    sql: ${TABLE}.id ;;

  }



  dimension_group: solved_ticket_at {
    label: "solved_ticket_at_mst"
    type: time
    timeframes: [
      date,
      week,
      month,
      year
    ]
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

  dimension: id {
    type: string
    sql: ${TABLE}.id ;;
  }

  set: detail {
    fields: [contact_reason, sub_category, id]
  }

  filter: solved_at {
    type: date
  }
}
