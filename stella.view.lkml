view: stella {
  sql_table_name: public.stella ;;

  dimension: additional_question_eligible {
    type: string
    sql: ${TABLE}.additional_question_eligible ;;
  }

  dimension: additional_question_id {
    type: string
    sql: ${TABLE}.additional_question_id ;;
  }

  dimension: additional_question_response_multiple_choice {
    type: string
    sql: ${TABLE}.additional_question_response_multiple_choice ;;
  }

  dimension: additional_question_response_scalar {
    type: string
    sql: ${TABLE}.additional_question_response_scalar ;;
  }

  dimension: additional_question_text {
    type: string
    sql: ${TABLE}.additional_question_text ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: custom_link_eligible {
    type: string
    sql: ${TABLE}.custom_link_eligible ;;
  }

  dimension: custom_link_initiated {
    type: string
    sql: ${TABLE}.custom_link_initiated ;;
  }

  dimension: customer_custom_id {
    type: string
    sql: ${TABLE}.customer_custom_id ;;
  }

  dimension: customer_email_address {
    type: string
    sql: ${TABLE}.customer_email_address ;;
  }

  dimension: customer_full_name {
    type: string
    sql: ${TABLE}.customer_full_name ;;
  }

  dimension: employee_custom_id {
    type: string
    sql: ${TABLE}.employee_custom_id ;;
  }

  dimension: employee_email_address {
    type: string
    sql: ${TABLE}.employee_email_address ;;
  }

  dimension: employee_first_name {
    type: string
    sql: ${TABLE}.employee_first_name ;;
  }

  dimension: employee_last_name {
    type: string
    sql: ${TABLE}.employee_last_name ;;
  }

  dimension: excellence_clear_information {
    type: string
    sql: ${TABLE}.excellence_clear_information ;;
  }

  dimension: excellence_efficient {
    type: string
    sql: ${TABLE}.excellence_efficient ;;
  }

  dimension: excellence_helpful {
    type: string
    sql: ${TABLE}.excellence_helpful ;;
  }

  dimension: excellence_knowledgable {
    type: string
    sql: ${TABLE}.excellence_knowledgable ;;
  }

  dimension: excellence_made_my_day {
    type: string
    sql: ${TABLE}.excellence_made_my_day ;;
  }

  dimension: excellence_personable {
    type: string
    sql: ${TABLE}.excellence_personable ;;
  }

  dimension: ext_interaction_id {
    type: string
    sql: ${TABLE}.ext_interaction_id ;;
  }

  dimension: external_url {
    type: string
    sql: ${TABLE}.external_url ;;
  }

  dimension: facebook_follow_eligible {
    type: string
    sql: ${TABLE}.facebook_follow_eligible ;;
  }

  dimension: facebook_follow_initiated {
    type: string
    sql: ${TABLE}.facebook_follow_initiated ;;
  }

  dimension: facebook_share_eligible {
    type: string
    sql: ${TABLE}.facebook_share_eligible ;;
  }

  dimension: facebook_share_initiated {
    type: string
    sql: ${TABLE}.facebook_share_initiated ;;
  }

  dimension: improvement_clarity {
    type: string
    sql: ${TABLE}.improvement_clarity ;;
  }

  dimension: improvement_effort {
    type: string
    sql: ${TABLE}.improvement_effort ;;
  }

  dimension: improvement_friendliness {
    type: string
    sql: ${TABLE}.improvement_friendliness ;;
  }

  dimension: improvement_knowledge {
    type: string
    sql: ${TABLE}.improvement_knowledge ;;
  }

  dimension: improvement_other {
    type: string
    sql: ${TABLE}.improvement_other ;;
  }

  dimension: improvement_professionalism {
    type: string
    sql: ${TABLE}.improvement_professionalism ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: request_delivery_status {
    type: string
    sql: ${TABLE}.request_delivery_status ;;
  }

  dimension: request_id {
    type: string
    sql: ${TABLE}.request_id ;;
  }

  dimension: request_sent_at {
    type: string
    sql: ${TABLE}.request_sent_at ;;
  }

  dimension: requested_via {
    type: string
    sql: ${TABLE}.requested_via ;;
  }

  dimension: response_received_at {
    type: string
    sql: ${TABLE}.response_received_at ;;
  }

  dimension: reward_eligible {
    type: string
    sql: ${TABLE}.reward_eligible ;;
  }

  dimension: reward_name {
    type: string
    sql: ${TABLE}.reward_name ;;
  }

  dimension: star_rating {
    type: string
    sql: ${TABLE}.star_rating ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }

  dimension: team_leader {
    type: string
    sql: ${TABLE}.team_leader ;;
  }

  dimension: team_leader_employee_custom_id {
    type: string
    sql: ${TABLE}.team_leader_employee_custom_id ;;
  }

  dimension: twitter_follow_eligible {
    type: string
    sql: ${TABLE}.twitter_follow_eligible ;;
  }

  dimension: twitter_follow_initiated {
    type: string
    sql: ${TABLE}.twitter_follow_initiated ;;
  }

  dimension: twitter_share_eligible {
    type: string
    sql: ${TABLE}.twitter_share_eligible ;;
  }

  dimension: twitter_share_initiated {
    type: string
    sql: ${TABLE}.twitter_share_initiated ;;
  }

  measure: count {
    type: count
    drill_fields: [reward_name, employee_first_name, employee_last_name, customer_full_name]
  }
}
