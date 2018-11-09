- dashboard: contact_reason_trend_by_season
  title: Contact Reason Trend by Season
  layout: newspaper
  elements:
  - title: Contact Reason by Season
    name: Contact Reason by Season
    model: zendesk
    explore: ticket_metrics
    type: looker_column
    fields:
    - dw_dim_dates.regular_season
    - tickets.count_solved_tickets
    - tickets.contact_reason
    pivots:
    - tickets.contact_reason
    filters: {}
    sorts:
    - dw_dim_dates.regular_season
    - tickets.contact_reason 0
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: right
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
    series_types: {}
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Season
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Solved Date: ticket_metrics.solved_date
      Contact Reason: tickets.contact_reason
    row: 0
    col: 0
    width: 24
    height: 9
  filters:
  - name: Solved Date
    title: Solved Date
    type: date_filter
    default_value: '2018'
    allow_multiple_values: true
    required: false
  - name: Contact Reason
    title: Contact Reason
    type: string_filter
    default_value: "-EMPTY"
    allow_multiple_values: true
    required: false
