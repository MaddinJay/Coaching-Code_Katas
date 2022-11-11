CLASS ycl_mars_rover DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_position,
             x TYPE int2,
             y TYPE int2,
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
    METHODS set_commands            IMPORTING it_commands TYPE ycl_mars_rover=>tt_commands.

    METHODS get_position            RETURNING VALUE(rs_position) TYPE ycl_mars_rover=>ts_position.
    METHODS get_direction           RETURNING VALUE(rv_direction) TYPE ty_direction.
    METHODS get_commands            RETURNING VALUE(rt_commands) TYPE ycl_mars_rover=>tt_commands.

    METHODS move_forward_backward.

  PRIVATE SECTION.
    DATA ms_position    TYPE ts_position.
    DATA mv_direction   TYPE ty_direction.
    DATA mt_commands    TYPE ycl_mars_rover=>tt_commands.

    METHODS move_forward  RETURNING VALUE(rv_position) TYPE i.
    METHODS move_backward RETURNING VALUE(rv_position) TYPE i.

ENDCLASS.

CLASS ycl_mars_rover IMPLEMENTATION.

  METHOD set_starting_position.
    ms_position = is_position.
  ENDMETHOD.

  METHOD set_direction.
    mv_direction = iv_direction.
  ENDMETHOD.

  METHOD set_commands.
    mt_commands = it_commands.
  ENDMETHOD.

  METHOD get_position.
    rs_position = ms_position.
  ENDMETHOD.

  METHOD get_direction.
    rv_direction = mv_direction.
  ENDMETHOD.

  METHOD get_commands.
    rt_commands = mt_commands.
  ENDMETHOD.

  METHOD move_forward_backward.
    ms_position-x = SWITCH #( mv_direction
                              WHEN mc_direction-north THEN move_forward( )
                              WHEN mc_direction-south THEN move_backward( ) ).
  ENDMETHOD.

  METHOD move_backward.
    rv_position = SWITCH #( ms_position-x
                            WHEN 1 THEN 4               " Grid 4x4 -> If 1 reached, go forward to 4
                            ELSE ms_position-x - 1 ).
  ENDMETHOD.

  METHOD move_forward.
    rv_position = SWITCH #( ms_position-x
                            WHEN 4 THEN 1               " Grid 4x4 -> If 4 reached, go back to 1
                            ELSE ms_position-x + 1 ).
  ENDMETHOD.

ENDCLASS.
