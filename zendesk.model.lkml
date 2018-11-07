connection: "redshift"

# include all the views
include: "*.view"

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

explore: organizations {}
explore: dw_dim_dates{}
explore: save_type_group{}

explore: ticket_fields {
  label: "Ticket Fields"

  join: tickets__fields {
    view_label: "Ticket Fields"
    sql_on: ${ticket_fields.id_field_name} = ${tickets__fields.ticket_id} ;;
    relationship: one_to_many
  }
}

explore: tickets {
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
  join: organizations {
    type: left_outer
    sql_on: ${zendesk_users.organization_id} = ${organizations.id} ;;
    relationship: many_to_one
  }
}

explore: groups {}

explore: tag_types {}

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

  join: dw_dim_dates {
    type: left_outer
    sql_on: trunc(${ticket_metrics.solved_date})=trunc(${dw_dim_dates.date_date}) ;;
    relationship: many_to_many
  }
}
