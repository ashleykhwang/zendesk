view: zendesk_contact_reason_sub_categories_created_at {
  derived_table: {
    sql: WITH zendesk_contact_reason_sub_categories_created_at AS
      (
        SELECT TRUNC(convert_timezone ('PST',t.created_at)) AS created_at,
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
               t.information_about_fff_membership_features_internal,
               t.product_type,
               t.where_is_my_order_internal,
               t.contact_reason_new,
               t.i_have_a_problem_with_my_received_order_internal,
               t.i_have_a_technical_problem_internal,
               t.manage_my_account_internal,
               t.i_want_to_cancel_internal,
               t.i_need_to_make_changes_to_my_order_internal,
               t.other_internal,
               t.id,
               t.status
        FROM  zendesk.tickets t
        WHERE   {% condition created_at %}  convert_timezone('PST',t.created_at) {% endcondition %}
      ),
      zendesk_contact_reason_sub_categories_created_at_2 AS
      (
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.modify_order AS sub_category,
               'modify_order' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.shipping AS sub_category,
               'shipping' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.cancel_result AS sub_category,
               'cancel_result' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.billing AS sub_category,
               'billing' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.fulfillment_issue AS sub_category,
               'fulfillment_issue' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.info_requested AS sub_category,
               'info_requested' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.tech_issue AS sub_category,
               'tech_issue' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.product_related AS sub_category,
               'product_related' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.order_customize_edit AS sub_category,
               'order_customize_edit' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.other AS sub_category,
               'other' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason,
               z.update AS sub_category,
               'update' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
             UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.information_about_fff_membership_features_internal AS sub_category,
               'information_about_fff_membership_features_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z

        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.product_type AS sub_category,
               'product_type' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.where_is_my_order_internal AS sub_category,
               'where_is_my_order_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.i_have_a_problem_with_my_received_order_internal AS sub_category,
               'i_have_a_problem_with_my_received_order_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.i_have_a_technical_problem_internal AS sub_category,
               'i_have_a_technical_problem_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.manage_my_account_internal AS sub_category,
               'manage_my_account_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
        UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.i_want_to_cancel_internal AS sub_category,
               'i_want_to_cancel_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
         UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.i_need_to_make_changes_to_my_order_internal AS sub_category,
               'i_need_to_make_changes_to_my_order_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
            UNION
        SELECT z.created_at AS created_at,
               z.contact_reason_new as contact_reason,
               z.other_internal AS sub_category,
               'other_internal' AS Category,
               z.id,z.status
        FROM zendesk_contact_reason_sub_categories_created_at z
      )
      SELECT DISTINCT zz.created_at,
             zz.contact_reason,
             zz.sub_category,
             zz.category,
             zz.id,zz.status
      FROM zendesk_contact_reason_sub_categories_created_at_2 zz

      order  by 1,
               2,
               3,
               4
 ;;
  }

  measure: count {
    type: count_distinct
    drill_fields: [detail*]
    sql: ${TABLE}.id ;;
  }


  dimension_group: ticket_created_at {
    type: time
    timeframes: [
      date,
      week,
      month,
      year
    ]
    sql: ${created_at} ;;
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

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  set: detail {
    fields: [
      created_at,
      contact_reason,
      sub_category,
      category,
      id,
      status
    ]
  }

  filter: created_at {
    type: date
  }
}
