CLASS ycl_mars_rover DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_position TYPE int1,
           BEGIN OF ts_position,
             x TYPE ty_position,
             y TYPE ty_position,
           END OF ts_position,
           tt_position TYPE STANDARD TABLE OF ts_position WITH DEFAULT KEY,

           BEGIN OF ENUM ty_direction STRUCTURE mc_direction BASE TYPE char1,
             no_direction VALUE IS INITIAL,
             north        VALUE 'N',
             south        VALUE 'S',
             west         VALUE 'W',
             east         VALUE 'E',
           END OF ENUM ty_direction STRUCTURE mc_direction,
           tt_commands TYPE STANDARD TABLE OF ty_direction WITH DEFAULT KEY.

    METHODS set_starting_position   IMPORTING is_position TYPE ycl_mars_rover=>ts_position.
    METHODS get_position            RETURNING VALUE(rs_position) TYPE ts_position.

    METHODS move IMPORTING it_commands TYPE tt_commands.

  PRIVATE SECTION.
    CONSTANTS mc_south_pole         TYPE ty_position VALUE 4.
    CONSTANTS mc_north_pole         TYPE ty_position VALUE 1.
    CONSTANTS mc_west_edge          TYPE ty_position VALUE 1.
    CONSTANTS mc_east_edge          TYPE ty_position VALUE 4.
    CONSTANTS mc_moving_step_length TYPE int1 VALUE 1.

    DATA ms_actual_position    TYPE ts_position.
    DATA mv_direction   TYPE ty_direction.
    DATA mt_sequence_positions   TYPE tt_position.

    METHODS move_forward.
    METHODS move_backward.
    METHODS move_left.
    METHODS move_right.
    METHODS move_vertical_down.
    METHODS move_vertical_up.
    METHODS move_horizontal_left.
    METHODS move_horizontal_right.

    METHODS is_south_pole_reached RETURNING VALUE(rv_is_reached) TYPE abap_bool.
    METHODS is_north_pole_reached RETURNING VALUE(rv_is_reached) TYPE abap_bool.
    METHODS is_west_edge_reached  RETURNING VALUE(rv_is_reached) TYPE abap_bool.
    METHODS is_east_edge_reached  RETURNING VALUE(rv_is_reached) TYPE abap_bool.
    METHODS move_to_east_edge.
    METHODS move_to_west_edge.
    METHODS notice_next_position.
    METHODS calculate_next_position IMPORTING iv_command TYPE ycl_mars_rover=>ty_direction.
    METHODS calculate_sequence_positions IMPORTING it_commands TYPE ycl_mars_rover=>tt_commands.
    METHODS set_position_back_to_start.
    METHODS scan_next_square
      RETURNING
        VALUE(rv_found) TYPE abap_bool.
    METHODS report_obstacle_found.
    METHODS go_ahead.

ENDCLASS.

CLASS ycl_mars_rover IMPLEMENTATION.

  METHOD move.
    calculate_sequence_positions( it_commands ).
*    set_position_back_to_start( ).
*    DATA(lv_found) = scan_next_square( ).
*    IF lv_found = abap_true.
*      report_obstacle_found( ).
*    ELSE.
*      go_ahead( ).
*    ENDIF.
  ENDMETHOD.

  METHOD calculate_sequence_positions.
    LOOP AT it_commands INTO DATA(lv_command).
      calculate_next_position( lv_command ).
      notice_next_position( ).
    ENDLOOP.
  ENDMETHOD.

  METHOD calculate_next_position.
    CASE iv_command.
      WHEN mc_direction-north. move_forward( ).
      WHEN mc_direction-south. move_backward( ).
      WHEN mc_direction-west.  move_left( ).
      WHEN mc_direction-east.  move_right( ).
    ENDCASE.
  ENDMETHOD.

  METHOD notice_next_position.
    APPEND ms_actual_position TO mt_sequence_positions.
  ENDMETHOD.

  METHOD get_position.
    TRY.
        rs_position = mt_sequence_positions[ lines( mt_sequence_positions ) ].
      CATCH cx_sy_itab_line_not_found.
        " Keine Position vorhanden -> Null Koordinaten ausgeben
    ENDTRY.
  ENDMETHOD.

  METHOD is_east_edge_reached.
    rv_is_reached = boolc( ms_actual_position-x = mc_east_edge ).
  ENDMETHOD.

  METHOD is_north_pole_reached.
    rv_is_reached = xsdbool( ms_actual_position-y = mc_north_pole ).
  ENDMETHOD.

  METHOD is_south_pole_reached .
    rv_is_reached = xsdbool( ms_actual_position-y = mc_south_pole ).
  ENDMETHOD.

  METHOD is_west_edge_reached.
    rv_is_reached = boolc( ms_actual_position-x = mc_west_edge ).
  ENDMETHOD.

  METHOD move_backward.
    IF is_south_pole_reached( ).
      move_vertical_up( ).
    ELSE.
      move_vertical_down( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_forward.
    IF is_north_pole_reached( ).
      move_vertical_down( ).
    ELSE.
      move_vertical_up( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_horizontal_left.
    ms_actual_position-x = ms_actual_position-x - mc_moving_step_length.
  ENDMETHOD.

  METHOD move_horizontal_right.
    ms_actual_position-x = ms_actual_position-x + mc_moving_step_length.
  ENDMETHOD.

  METHOD move_left.
    IF is_west_edge_reached( ).
      move_to_east_edge( ).
    ELSE.
      move_horizontal_left( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_to_east_edge.
    ms_actual_position-x = mc_east_edge.
  ENDMETHOD.

  METHOD move_right.
    IF is_east_edge_reached( ).
      move_to_west_edge( ).
    ELSE.
      move_horizontal_right( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_to_west_edge.
    ms_actual_position-x = mc_west_edge.
  ENDMETHOD.

  METHOD move_vertical_down.
    ms_actual_position-y = ms_actual_position-y + mc_moving_step_length.
  ENDMETHOD.

  METHOD move_vertical_up.
    ms_actual_position-y = ms_actual_position-y - mc_moving_step_length.
  ENDMETHOD.

  METHOD set_starting_position.
    ms_actual_position = is_position.
    APPEND is_position TO mt_sequence_positions.
  ENDMETHOD.

  METHOD set_position_back_to_start.
    ms_actual_position = mt_sequence_positions[ 1 ].
  ENDMETHOD.

  METHOD scan_next_square.

  ENDMETHOD.

  METHOD report_obstacle_found.

  ENDMETHOD.

  METHOD go_ahead.

  ENDMETHOD.

ENDCLASS.
