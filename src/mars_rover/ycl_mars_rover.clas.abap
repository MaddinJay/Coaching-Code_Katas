CLASS ycl_mars_rover DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_position TYPE int1,
           BEGIN OF ts_position,
             x TYPE ty_position,
             y TYPE ty_position,
           END OF ts_position,

           BEGIN OF ENUM ty_direction STRUCTURE mc_direction BASE TYPE char1,
             no_direction VALUE IS INITIAL,
             north        VALUE 'N',
             south        VALUE 'S',
             west         VALUE 'W',
             east         VALUE 'E',
           END OF ENUM ty_direction STRUCTURE mc_direction,
           tt_commands TYPE STANDARD TABLE OF int2 WITH DEFAULT KEY.

    METHODS set_starting_position   IMPORTING is_position TYPE ycl_mars_rover=>ts_position.
    METHODS set_direction           IMPORTING iv_direction TYPE ty_direction.
    METHODS get_position            RETURNING VALUE(rs_position) TYPE ts_position.

    METHODS move.

  PRIVATE SECTION.
    CONSTANTS mc_south_pole         TYPE ty_position VALUE 4.
    CONSTANTS mc_north_pole         TYPE ty_position VALUE 1.
    CONSTANTS mc_west_edge          TYPE ty_position VALUE 1.
    CONSTANTS mc_east_edge          TYPE ty_position VALUE 4.
    CONSTANTS mc_moving_step_length TYPE i VALUE 1.

    DATA ms_position    TYPE ts_position.
    DATA mv_direction   TYPE ty_direction.

    METHODS move_forward  RETURNING VALUE(rv_position) TYPE i.
    METHODS move_backward RETURNING VALUE(rv_position) TYPE i.
    METHODS move_left     RETURNING VALUE(rv_position) TYPE i.
    METHODS move_right    RETURNING VALUE(rv_position) TYPE i.
    METHODS move_vertical_down.
    METHODS move_vertical_up.
    METHODS move_horizontal_left.
    METHODS move_horizontal_right.

    METHODS is_south_pole_reached RETURNING VALUE(rv_is_reached) TYPE abap_bool.
    METHODS is_north_pole_reached RETURNING VALUE(rv_is_reached) TYPE abap_bool.
    METHODS is_west_edge_reached  RETURNING VALUE(rv_is_reached) TYPE abap_bool.
    METHODS is_east_edge_reached  RETURNING VALUE(rv_is_reached) TYPE abap_bool.

ENDCLASS.

CLASS ycl_mars_rover IMPLEMENTATION.

  METHOD set_direction.
    mv_direction = iv_direction.
  ENDMETHOD.

  METHOD get_position.
    rs_position = ms_position.
  ENDMETHOD.

  METHOD set_starting_position.
    ms_position = is_position.
  ENDMETHOD.

  METHOD move.
    CASE mv_direction.
      WHEN mc_direction-north. move_forward( ).
      WHEN mc_direction-south. move_backward( ).
      WHEN mc_direction-west.  move_left( ).
      WHEN mc_direction-east.  move_right( ).
    ENDCASE.
  ENDMETHOD.

  METHOD is_north_pole_reached.
    rv_is_reached = xsdbool( ms_position-y = mc_north_pole ).
  ENDMETHOD.

  METHOD is_south_pole_reached .
    rv_is_reached = xsdbool( ms_position-y = mc_south_pole ).
  ENDMETHOD.

  METHOD move_backward.
    IF is_south_pole_reached( ).
      move_forward( ).
    ELSE.
      move_vertical_down( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_forward.
    IF is_north_pole_reached( ).
      move_backward( ).
    ELSE.
      move_vertical_up( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_left.
    IF is_west_edge_reached( ).
      ms_position-x = mc_east_edge.
    ELSE.
      move_horizontal_left( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_vertical_down.
    ms_position-y = ms_position-y + mc_moving_step_length.
  ENDMETHOD.

  METHOD move_right.
    IF is_east_edge_reached( ).
      ms_position-x = mc_west_edge.
    ELSE.
      move_horizontal_right( ).
    ENDIF.
  ENDMETHOD.

  METHOD move_vertical_up.
    ms_position-y = ms_position-y - mc_moving_step_length.
  ENDMETHOD.

  METHOD is_west_edge_reached.
    rv_is_reached = boolc( ms_position-x = mc_west_edge ).
  ENDMETHOD.

  METHOD move_horizontal_left.
    ms_position-x = ms_position-x - mc_moving_step_length.
  ENDMETHOD.

  METHOD is_east_edge_reached.
    rv_is_reached = boolc( ms_position-x = mc_east_edge ).
  ENDMETHOD.

  METHOD move_horizontal_right.
    ms_position-x = ms_position-x + mc_moving_step_length.
  ENDMETHOD.

ENDCLASS.
