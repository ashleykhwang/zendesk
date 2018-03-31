view: tickets {
  sql_table_name: zendesk.tickets ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: contact_reason {
    type: string
    sql: ${TABLE}.contact_reason ;;
  }

  dimension: compensation {
    type: string
    sql: ${TABLE}.compensation ;;
  }

  dimension: uuid_ts {
    type: date_time
    sql: ${TABLE}.uuid_ts ;;
  }

  dimension: satisfaction_rating_season {
    type: string
    sql: ${TABLE}.satisfaction_rating_season ;;
  }

  dimension: satisfaction_rating_season_id {
    type: number
    sql: ${TABLE}.satisfaction_rating_season_id ;;
  }

  dimension: tags_2 {
    type: string
    sql: ${TABLE}.tags_2 ;;
  }

  dimension: cancel_result {
    type: string
    sql: ${TABLE}.cancel_result ;;
  }

  dimension: billing {
    type: string
    sql: ${TABLE}.billing ;;
  }

  dimension: fulfillment_issue {
    type: string
    sql: ${TABLE}.fulfillment_issue ;;
  }

  dimension: info_requested {
    type: string
    sql: ${TABLE}.info_requested ;;
  }

  dimension: order_customize_edit {
    type: string
    sql: ${TABLE}.order_customize_edit ;;
  }

  dimension: other {
    type: string
    sql: ${TABLE}.other ;;
  }

  dimension: product_related {
    type: string
    sql: ${TABLE}.product_related ;;
  }

  dimension: shipping {
    type: string
    sql: ${TABLE}.shipping ;;
  }

  dimension: tech_issue {
    type: string
    sql: ${TABLE}.tech_issue ;;
  }

  dimension: time_spent_last_update_sec {
    type: string
    sql: ${TABLE}.time_spent_last_update_sec ;;
  }

  dimension: total_time_spent_sec {
    type: string
    sql: ${TABLE}.total_time_spent_sec ;;
  }

  dimension: update {
    type: string
    sql: ${TABLE}.update ;;
  }

  dimension: do_not_send_stella_connect_request {
    type: yesno
    sql: ${TABLE}.do_not_send_stella_connect_request ;;
  }

  dimension: style_account_update {
    type: string
    sql: ${TABLE}.style_account_update ;;
  }

  dimension: style_shipping {
    type: string
    sql: ${TABLE}.style_account_shipping ;;
  }

  dimension: style_billing {
    type: string
    sql: ${TABLE}.style_account_billing ;;
  }

  dimension: style_info_requested {
    type: string
    sql: ${TABLE}.style_account_info_requested ;;
  }

  dimension: style_action {
    type: string
    sql: ${TABLE}.style_action ;;
  }

  dimension: style_product_feedback {
    type: string
    sql: ${TABLE}.style_product_feedback ;;
  }

  dimension: style_cancel_result {
    type: string
    sql: ${TABLE}.style_cancel_result ;;
  }

  dimension: style_fulfillment {
    type: string
    sql: ${TABLE}.style_fulfillment ;;
  }

  dimension: style_feedback {
    type: string
    sql: ${TABLE}.style_feedback ;;
  }

  dimension: verification {
    type: yesno
    sql: ${TABLE}.verification ;;
  }

  dimension: style_contact_reason {
    type: string
    sql: ${TABLE}.style_contact_reason ;;
  }

  dimension: brand_id {
    type: number
    sql: ${TABLE}.brand_id ;;
  }

  dimension: assignee_email {
    description: "the requester is the customer who initiated the ticket. the email is retrieved from the `users` table."
    sql: ${assignees.email} ;;
  }

  ## include only if your Zendesk application utilizes the assignee_id field
  dimension: assignee_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.assignee_id ;;
  }

  #   - dimension: brand_id      ## include only if your Zendesk application utilizes the brand field
  #     value_format_name: id                ## only associated with Zendesk Enterprise Accounts
  #     type: number
  #     sql: ${TABLE}.brand_id

  dimension_group: created_at {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at::timestamp ;;
  }

  dimension: group_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.group_id ;;
  }

  dimension: organization_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.organization_id ;;
  }

  dimension: organization_name {
    type: string
    sql: ${organizations.name} ;;
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
  }

  dimension: requester_email {
    description: "the requester is the customer who initiated the ticket. the email is retrieved from the `users` table."
    sql: ${requesters.email} ;;
  }

  dimension: requester_id {
    description: "the requester is the customer who initiated the ticket"
    type: number
    value_format_name: id
    sql: ${TABLE}.requester_id ;;
  }

  #   - dimension: satisfaction_rating__comment
  #     type: string
  #     sql: ${TABLE}.satisfaction_rating__comment
  #
  #   - dimension: satisfaction_rating__id
  #     type: number
  #     sql: ${TABLE}.satisfaction_rating__id
  #
  #   - dimension: satisfaction_rating__score
  #     type: string
  #     sql: ${TABLE}.satisfaction_rating__score

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  ## depending on use, either this field or "via_channel" will represent the channel the ticket came through
  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  ## The submitter is always the first to comment on a ticket
  dimension: submitter_id {
    description: "a submitter is either a customer or an agent submitting on behalf of a customer"
    type: number
    value_format_name: id
    sql: ${TABLE}.submitter_id ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: via__channel {
    type: string
    sql: ${TABLE}.via__channel ;;
  }

  measure: count {
    type: count
    drill_fields: [id, requester_email]
  }

  # ----- ADDITIONAL FIELDS -----

  dimension: is_backlogged {
    type: yesno
    sql: ${status} = 'pending' ;;
  }

  dimension: is_new {
    type: yesno
    sql: ${status} = 'new' ;;
  }

  dimension: is_open {
    type: yesno
    sql: ${status} = 'open' ;;
  }

  dimension: is_solved {
    description: "solved tickets have either a solved or closed status"
    type: yesno
    sql: ${status} = 'solved' OR ${status} = 'closed' ;;
  }

  dimension: subject_category {
    sql: CASE
      WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
      WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
      WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
      ELSE 'Other'
      END
       ;;
  }

  measure: count_pending_tickets {
    type: count

    filters: {
      field: is_backlogged
      value: "Yes"
    }
  }

  measure: count_new_tickets {
    type: count

    filters: {
      field: is_new
      value: "Yes"
    }
  }

  measure: count_open_tickets {
    type: count

    filters: {
      field: is_open
      value: "Yes"
    }
  }

  measure: count_solved_tickets {
    type: count

    filters: {
      field: is_solved
      value: "Yes"
    }
  }

  measure: count_distinct_organizations {
    type: count_distinct
    sql: ${organization_id} ;;
  }

  measure: count_orgs_submitting {
    type: count_distinct
    sql: ${organizations.name} ;;

    filters: {
      field: organization_name
      value: "-NULL"
    }
  }

  ############ TIME FIELDS ###########

  dimension_group: time {
    type: time
    ###   use day_of_week
    timeframes: [day_of_week, hour_of_day]
    sql: ${TABLE}.created_at::timestamp ;;
  }
}

#   - dimension: created_day_of_week
#     sql_case:
#       Sunday:    ${hidden_created_day_of_week_index} = 6
#       Monday:    ${hidden_created_day_of_week_index} = 0
#       Tuesday:   ${hidden_created_day_of_week_index} = 1
#       Wednesday: ${hidden_created_day_of_week_index} = 2
#       Thursday:  ${hidden_created_day_of_week_index} = 3
#       Friday:    ${hidden_created_day_of_week_index} = 4
#       Saturday:  ${hidden_created_day_of_week_index} = 5

### REVIEW
#   - dimension: satisfaction_rating_percent_tier
#     type: tier
#     tiers: [10,20,30,40,50,60,70,80,90]
#     sql: ${satisfaction_rating}
#
#   - measure: average_satisfaction_rating
#     type: avg
#     sql: ${satisfaction_rating}
#     value_format: '#,#00.00%'


### REVIEW BELOW
# ----- Sets of fields for drilling ------
#   sets:
#     detail:
#     - via__source__from__ticket_id
#     - via__source__from__name
#     - via__source__to__name
#     - organizations.id
#     - organizations.name
#     - audits.count
#     - zendesk_ticket_metrics.count
