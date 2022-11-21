CLASS ycl_mr_position_sequence DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS calculate_sequence IMPORTING it_commands          TYPE yif_mr_types=>tt_commands
                                         is_starting_position TYPE yif_mr_types=>ts_position.
    METHODS get_sequence        RETURNING VALUE(rt_sequence) TYPE yif_mr_types=>tt_position.
    METHODS get_next_position   RETURNING VALUE(rs_position) TYPE yif_mr_types=>ts_position.

  PRIVATE SECTION.
    CONSTANTS mc_south_pole         TYPE yif_mr_types=>ty_position VALUE 4.
    CONSTANTS mc_north_pole         TYPE yif_mr_types=>ty_position VALUE 1.
    CONSTANTS mc_west_edge          TYPE yif_mr_types=>ty_position VALUE 1.
    CONSTANTS mc_east_edge          TYPE yif_mr_types=>ty_position VALUE 4.
    CONSTANTS mc_moving_step_length TYPE int1 VALUE 1.

    DATA mt_sequence                TYPE yif_mr_types=>tt_position.
    DATA ms_actual_position         TYPE yif_mr_types=>ts_position.
    DATA mv_position_counter        TYPE int1 VALUE 1.

    METHODS calculate_next_position IMPORTING iv_command TYPE yif_mr_types=>ty_direction.
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
    METHODS set_starting_point    IMPORTING is_starting_position TYPE yif_mr_types=>ts_position.

ENDCLASS.



CLASS ycl_mr_position_sequence IMPLEMENTATION.


  METHOD calculate_next_position.
    CASE iv_command.
      WHEN yif_mr_types=>mc_direction-north. move_forward( ).
      WHEN yif_mr_types=>mc_direction-south. move_backward( ).
      WHEN yif_mr_types=>mc_direction-west.  move_left( ).
      WHEN yif_mr_types=>mc_direction-east.  move_right( ).
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
