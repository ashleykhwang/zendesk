view: tickets {
  sql_table_name: zendesk.tickets ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: description {
    hidden: yes
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
    hidden: yes
    type: date_time
    sql: ${TABLE}.uuid_ts ;;
  }

  dimension: satisfaction_rating_reason {
    hidden: yes
    type: string
    sql: ${TABLE}.satisfaction_rating_reason ;;
  }

  dimension: satisfaction_rating_reason_id {
    hidden: yes
    type: number
    sql: ${TABLE}.satisfaction_rating_reason_id ;;
  }

  dimension: tags_2 {
    hidden: yes
    type: string
    sql: ${TABLE}.tags_2 ;;
  }

  dimension: cancel_result {
    type: string
    sql: ${TABLE}.cancel_result ;;
  }

  dimension: cancel_result_saved {
    type: string
    sql:case when  ${TABLE}.cancel_result in ('save__other','save__select','save__change_bill_date','save__discount',
    'save__ship_date','save__free_product','save__education','save__skip') then
    ${TABLE}.cancel_result else 'OTHER' END;;
  }

  dimension: billing {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.billing ;;
  }

  dimension: fulfillment_issue {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.fulfillment_issue ;;
  }

  dimension: modify_order {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.modify_order ;;
  }

  dimension: info_requested {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.info_requested ;;
  }

  dimension: order_customize_edit {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.order_customize_edit ;;
  }

  dimension: other {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.other ;;
  }

  dimension: product_related {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.product_related ;;
  }

  dimension: shipping {
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.shipping ;;
  }

  dimension: tech_issue {
    group_label: "Contact Reason Category"
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
    group_label: "Contact Reason Category"
    type: string
    sql: ${TABLE}.update ;;
  }

  dimension: do_not_send_stella_connect_request {
    type: yesno
    sql: ${TABLE}.do_not_send_stella_connect_request ;;
  }

  dimension: style_account_update {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_account_update ;;
  }

  dimension: style_shipping {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_shipping ;;
  }

  dimension: style_billing {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_billing ;;
  }

  dimension: style_info_requested {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_info_requested ;;
  }

  dimension: style_action {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_action ;;
  }

  dimension: style_product_feedback {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_product_feedback ;;
  }

  dimension: style_cancel_result {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_cancel_result ;;
  }

  dimension: style_fulfillment {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_fulfillment ;;
  }

  dimension: style_feedback {
    group_label: "Style Contact Reason Category"
    type: string
    sql: ${TABLE}.style_feedback ;;
  }

  dimension: verification {
    group_label: "Style Contact Reason Category"
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

  dimension: stella_connect_star_rating {
    type: number
    sql: ${TABLE}.stella_connect_star_rating;;
  }

  dimension: assignee_email {
    group_label: "Assignee"
    description: "the requester is the customer who initiated the ticket. the email is retrieved from the `users` table."
    sql: ${assignees.email} ;;
  }

  ## include only if your Zendesk application utilizes the assignee_id field
  dimension: assignee_id {
    group_label: "Assignee"
    type: number
    value_format_name: id
    sql: ${TABLE}.assignee_id ;;
  }

  #   - dimension: brand_id      ## include only if your Zendesk application utilizes the brand field
  #     value_format_name: id                ## only associated with Zendesk Enterprise Accounts
  #     type: number
  #     sql: ${TABLE}.brand_id

  dimension_group: created_at {
    description: "PST Time Zone"
    type: time
    timeframes: [time, date, week, month]
    sql: convert_timezone('PST',${TABLE}.created_at)::timestamp ;;
  }

  dimension: group_id {
    type: number
    value_format_name: id
    sql: ${TABLE}.group_id ;;
  }

  dimension: organization_id {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.organization_id ;;
  }

  dimension: organization_name {
    hidden: yes
    type: string
    sql: ${organizations.name} ;;
  }

  dimension: recipient {
    type: string
    sql: ${TABLE}.recipient ;;
  }

  dimension: requester_email {
    group_label: "Requester"
    description: "the requester is the customer who initiated the ticket. the email is retrieved from the `users` table."
    sql: ${requesters.email} ;;
  }

  dimension: requester_id {
    group_label: "Requester"
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
    hidden: yes
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
    hidden: yes
    type: string
    sql: ${TABLE}.via__channel ;;
  }

  measure: count {
    type: count
    drill_fields: [id, requester_email]
  }

  # ----- ADDITIONAL FIELDS -----

  dimension: is_backlogged {
    group_label: "Ticket Status Flag"
    type: yesno
    sql: ${status} = 'pending' ;;
  }

  dimension: is_new {
    group_label: "Ticket Status Flag"
    type: yesno
    sql: ${status} = 'new' ;;
  }

  dimension: is_open {
    group_label: "Ticket Status Flag"
    type: yesno
    sql: ${status} = 'open' ;;
  }

  dimension: is_solved {
    group_label: "Ticket Status Flag"
    description: "solved tickets have either a solved or closed status"
    type: yesno
    sql: ${status} = 'solved' OR ${status} = 'closed' ;;
  }

  dimension: subject_category {
    hidden: yes
    sql: CASE
      WHEN ${subject} LIKE 'Chat%' THEN 'Chat'
      WHEN ${subject} LIKE 'Offline message%' THEN 'Offline Message'
      WHEN ${subject} LIKE 'Phone%' THEN 'Phone Call'
      ELSE 'Other'
      END
       ;;
  }

  measure: count_pending_tickets {
    label: "Count Pending Tickets"
    group_label: "Count of Tickets"
    type: count

    filters: {
      field: is_backlogged
      value: "Yes"
    }
  }

  measure: count_new_tickets {
    label: "Count New Tickets"
    group_label: "Count of Tickets"
    type: count

    filters: {
      field: is_new
      value: "Yes"
    }
  }

  measure: count_open_tickets {
    label: "Count Open Tickets"
    group_label: "Count of Tickets"
    type: count

    filters: {
      field: is_open
      value: "Yes"
    }
  }

  measure: count_solved_tickets {
    label: "Count Solved Tickets"
    group_label: "Count of Tickets"
    type: count

    filters: {
      field: is_solved
      value: "Yes"
    }
  }

  measure: count_distinct_organizations {
    hidden: yes
    type: count_distinct
    sql: ${organization_id} ;;
  }

  measure: count_orgs_submitting {
    hidden: yes
    type: count_distinct
    sql: ${organizations.name} ;;

    filters: {
      field: organization_name
      value: "-NULL"
    }
  }

  measure: median_total_time_spent_minutes {
    group_label: "Total Time Spent in Minutes Measures"
    hidden: no
    type: median
    sql: ${total_time_spent_sec}/60 ;;
  }

  measure: max_total_time_spent_minutes {
    group_label: "Total Time Spent in Minutes Measures"
    hidden: no
    type: max
    sql: ${total_time_spent_sec}/60 ;;
  }

  measure: min_total_time_spent_minutes {
    group_label: "Total Time Spent in Minutes Measures"
    hidden: no
    type: min
    sql: ${total_time_spent_sec}/60 ;;
  }

  measure: median_time_spent_last_update_minutes {
    group_label: "Time Spent since Last Update in Minutes Measures"
    hidden: no
    type: median
    sql: ${time_spent_last_update_sec}/60 ;;
  }

  measure: max_time_spent_last_update_minutes {
    group_label: "Time Spent since Last Update in Minutes Measures"
    hidden: no
    type: max
    sql: ${time_spent_last_update_sec}/60 ;;
  }

  measure: min_time_spent_last_update_minutes {
    group_label: "Time Spent since Last Update in Minutes Measures"
    hidden: no
    type: min
    sql: ${time_spent_last_update_sec}/60 ;;
  }


  ############ TIME FIELDS ###########

  dimension_group: time {
    type: time
    ###   use day_of_week
    timeframes: [day_of_week, hour_of_day]
    sql: ${TABLE}.created_at::timestamp ;;
  }

}

#  dimension: created_day_of_week {
#    type: date_day_of_week
#      Sunday:    ${hidden_created_day_of_week_index} = 6
#      Monday:    ${hidden_created_day_of_week_index} = 0
#      Tuesday:   ${hidden_created_day_of_week_index} = 1
#      Wednesday: ${hidden_created_day_of_week_index} = 2
#      Thursday:  ${hidden_created_day_of_week_index} = 3
#      Friday:    ${hidden_created_day_of_week_index} = 4
#      Saturday:  ${hidden_created_day_of_week_index} = 5 ;;
#
#    }



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
