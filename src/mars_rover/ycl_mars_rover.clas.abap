CLASS ycl_mars_rover DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_position,
             x TYPE int2,
             y TYPE int2,
           END OF ts_position,
           BEGIN OF ts_direction,
             north TYPE int2,
             south TYPE int2,
             east  TYPE int2,
             west  TYPE int2,
           END OF ts_direction.

    METHODS set_starting_position IMPORTING is_position TYPE ycl_mars_rover=>ts_position.
    METHODS get_position RETURNING VALUE(rs_position) TYPE ycl_mars_rover=>ts_position.

    METHODS set_direction IMPORTING is_direction TYPE ts_direction.
    METHODS get_direction RETURNING VALUE(rs_direction) TYPE ts_direction.

  PRIVATE SECTION.
    DATA ms_position  TYPE ts_position.
    DATA ms_direction TYPE ts_direction.

ENDCLASS.

CLASS ycl_mars_rover IMPLEMENTATION.

  METHOD get_position.
    rs_position = ms_position.
  ENDMETHOD.

  METHOD set_starting_position.
    ms_position = is_position.
  ENDMETHOD.

  METHOD set_direction.
    ms_direction = is_direction.
  ENDMETHOD.

  METHOD get_direction.
    rs_direction = ms_direction.
  ENDMETHOD.

ENDCLASS.
