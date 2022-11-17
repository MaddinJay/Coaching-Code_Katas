CLASS ycl_mr_postion_sequence DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_position TYPE int1,
           BEGIN OF ts_position,
             x TYPE ty_position,
             y TYPE ty_position,
           END OF ts_position,
           tt_position TYPE STANDARD TABLE OF ts_position WITH DEFAULT KEY.

    METHODS     calculate_sequence IMPORTING it_commands          TYPE ycl_mars_rover=>tt_commands
                                             is_starting_position TYPE ycl_mars_rover=>ts_position.
    METHODS get_sequence
      RETURNING
        VALUE(rt_sequence) TYPE ycl_mars_rover=>tt_position.
    METHODS get_next_position
      RETURNING
        VALUE(rs_position) TYPE ycl_mars_rover=>ts_position.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS mc_south_pole         TYPE ty_position VALUE 4.
    CONSTANTS mc_north_pole         TYPE ty_position VALUE 1.
    CONSTANTS mc_west_edge          TYPE ty_position VALUE 1.
    CONSTANTS mc_east_edge          TYPE ty_position VALUE 4.
    CONSTANTS mc_moving_step_length TYPE int1 VALUE 1.
    DATA mt_sequence TYPE ycl_mars_rover=>tt_position.
    DATA ms_actual_position TYPE ycl_mars_rover=>ts_position.
    DATA mv_position_counter TYPE int1 VALUE 1.

    METHODS calculate_next_position IMPORTING iv_command TYPE ycl_mars_rover=>ty_direction.
    METHODS notice_position.
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
    METHODS set_starting_point
      IMPORTING
        is_starting_position TYPE ycl_mars_rover=>ts_position.

ENDCLASS.



CLASS ycl_mr_postion_sequence IMPLEMENTATION.


  METHOD calculate_next_position.
    CASE iv_command.
      WHEN ycl_mars_rover=>mc_direction-north. move_forward( ).
      WHEN ycl_mars_rover=>mc_direction-south. move_backward( ).
      WHEN ycl_mars_rover=>mc_direction-west.  move_left( ).
      WHEN ycl_mars_rover=>mc_direction-east.  move_right( ).
    ENDCASE.
  ENDMETHOD.

  METHOD calculate_sequence.
    set_starting_point( is_starting_position ).
    notice_position( ).

    LOOP AT it_commands INTO DATA(lv_command).
      calculate_next_position( lv_command ).
      notice_position( ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_next_position.
    mv_position_counter = mv_position_counter + 1.
    TRY.
        rs_position = mt_sequence[ mv_position_counter ].
      CATCH cx_sy_itab_line_not_found.
        rs_position = mt_sequence[ lines( mt_sequence ) ].
    ENDTRY.
  ENDMETHOD.

  METHOD get_sequence.
    rt_sequence = mt_sequence.
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


  METHOD move_right.
    IF is_east_edge_reached( ).
      move_to_west_edge( ).
    ELSE.
      move_horizontal_right( ).
    ENDIF.
  ENDMETHOD.


  METHOD move_to_east_edge.
    ms_actual_position-x = mc_east_edge.
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


  METHOD notice_position.
    APPEND ms_actual_position TO mt_sequence.
  ENDMETHOD.


  METHOD set_starting_point.
    ms_actual_position = is_starting_position.
  ENDMETHOD.
ENDCLASS.
