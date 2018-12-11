connection: "redshift"

# include all the views
include: "*.view"
# include: "/fff_analytics/dw_user_cube.view.lkml"
include: "/fff_analytics/dw_dim_dates.view.lkml"
include: "/fff_analytics/subscriber_season.view.lkml"
include: "/fff_analytics/dw_master_dates.view.lkml"
# include all the dashboards
include: "*.dashboard"

explore: audits {
  label: "Ticket Changes"

  join: tickets {
    type: left_outer
    sql_on: ${audits.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: requesters {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.requester_id} = ${requesters.id} ;;
    relationship: many_to_one
  }

  join: assignees {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.assignee_id} = ${assignees.id} ;;
    relationship: many_to_one
  }

  join: audits__events {
    #       type: left_outer
    view_label: "Ticket Changes"
    sql_on: ${audits.id} = ${audits__events.audit_id} ;;
    relationship: one_to_many
  }
}

# - explore: audits__events
#   joins:
#     - join: audits
#       type: left_outer
#       sql_on: ${audits__events._rjm_source_key_id} = ${audits.id}
#       relationship: many_to_one
#
#     - join: tickets
#       type: left_outer
#       sql_on: ${audits.ticket_id} = ${tickets.id}
#       relationship: many_to_one
#
#     - join: organizations
#       type: left_outer
#       sql_on: ${tickets.organization_id} = ${organizations.id}
#       relationship: many_to_one
#
#     - join: requesters
#       from: users
#       type: left_outer
#       sql_on: ${tickets.requester_id} = ${requesters.id}
#       relationship: many_to_one
#
#     - join: assignees
#       from: users
#       type: left_outer
#       sql_on: ${tickets.assignee_id} = ${assignees.id}
#       relationship: many_to_one

explore: organizations {hidden:yes}
# explore: dw_dim_dates{}
explore: save_type_group{}
explore: save_type_tactics{hidden:yes}

explore: ticket_fields {
  label: "Ticket Fields"

  join: tickets__fields {
    view_label: "Ticket Fields"
    sql_on: ${ticket_fields.id_field_name} = ${tickets__fields.ticket_id} ;;
    relationship: one_to_many
  }
}

explore: tickets {
  hidden:yes
  fields: [ALL_FIELDS*,-dw_dim_dates.seasons_since]
  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: requesters {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.requester_id} = ${requesters.id} ;;
    relationship: many_to_one
  }

  join: assignees {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.assignee_id} = ${assignees.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${tickets.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }


  join: dw_dim_dates {
    type: left_outer
    sql_on: ${tickets.created_at_date}=${dw_dim_dates.date_date} ;;
    relationship: one_to_one
  }
}

# - explore: tickets__fields
#   view_label: 'Ticket fields'

explore: ticket__tags {
  join: tickets {
    type: left_outer
    sql_on: ${ticket__tags.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: requesters {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.requester_id} = ${requesters.id} ;;
    relationship: many_to_one
  }

  join: assignees {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.assignee_id} = ${assignees.id} ;;
    relationship: many_to_one
  }
}

explore: zendesk_users {
  hidden:yes
  join: organizations {
    type: left_outer
    sql_on: ${zendesk_users.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: groups {hidden:yes}

explore: tag_types {}
explore: contact_reason_by_subcategory {hidden:yes}

explore: ticket_metrics {

  join: tickets {
    type: left_outer
    sql_on: ${ticket_metrics.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: zendesk_users {
    type: left_outer
    sql_on: ${tickets.assignee_id} = ${zendesk_users.id} ;;
    relationship: many_to_one
  }

  join: groups {
    type: left_outer
    sql_on: ${tickets.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: requesters {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.requester_id} = ${requesters.id} ;;
    relationship: many_to_one
  }

  join: assignees {
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.assignee_id} = ${assignees.id} ;;
    relationship: many_to_one
  }

}

explore: ticket_metrics_save {
  from: ticket_metrics
  view_label: "cancel_result_save_tactics"
  fields: [ALL_FIELDS*,-dw_dim_dates.seasons_since,
    -subscriber_season.member_active_as_of_date,
    -subscriber_season.ab_total_non_expired_users,-subscriber_season.ab_total_edit_eligible_members]

  join: tickets {
    type: left_outer
    sql_on: ${ticket_metrics_save.ticket_id} = ${tickets.id} ;;
    relationship: many_to_one
  }

  join: organizations {
    fields: []
    type: left_outer
    sql_on: ${tickets.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }

  join: zendesk_users {
    fields: []
    type: left_outer
    sql_on: ${tickets.requester_id} = ${zendesk_users.id} ;;
    relationship: one_to_one
  }

  join: groups {
    fields: []
    type: left_outer
    sql_on: ${tickets.group_id} = ${groups.id} ;;
    relationship: many_to_one
  }

  join: requesters {
    fields:[]
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.requester_id} = ${requesters.id} ;;
    relationship: many_to_one
  }

  join: assignees {
    fields: []
    from: zendesk_users
    type: left_outer
    sql_on: ${tickets.assignee_id} = ${assignees.id} ;;
    relationship: many_to_one
  }


  join: dw_dim_dates {
    type: left_outer
    sql_on: trunc(${ticket_metrics_save.solved_date})=trunc(${dw_dim_dates.date_date}) ;;
    relationship: many_to_many
  }

  join: subscriber_season {
    type: left_outer
    sql_on: ${zendesk_users.email}=${subscriber_season.account_code}
    and ${dw_dim_dates.season_number} <= ${subscriber_season.sale_season_number} ;;
    relationship: many_to_many
  }


}
