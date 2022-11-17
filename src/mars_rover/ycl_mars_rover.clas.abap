CLASS ycl_mars_rover DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    ##TODO " Migrate types in interface
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


    METHODS move IMPORTING it_commands TYPE tt_commands.

    METHODS constructor.
    METHODS get_position
      RETURNING
        VALUE(rs_position) TYPE ycl_mars_rover=>ts_position.

  PRIVATE SECTION.

    DATA ms_actual_position    TYPE ts_position.
    DATA mv_direction   TYPE ty_direction.
    DATA mo_sequence TYPE REF TO ycl_mr_postion_sequence.

    METHODS calculate_sequence_positions IMPORTING it_commands TYPE ycl_mars_rover=>tt_commands.

    METHODS report_obstacle_found.
    METHODS go_ahead.
    METHODS get_next_position RETURNING VALUE(r_result) TYPE ycl_mars_rover=>ts_position.
    METHODS is_end_reached IMPORTING is_next_position         TYPE ycl_mars_rover=>ts_position
                           RETURNING VALUE(rv_is_not_reached) TYPE abap_bool.
    METHODS do_step            IMPORTING is_next_position TYPE ycl_mars_rover=>ts_position.

ENDCLASS.

CLASS ycl_mars_rover IMPLEMENTATION.

  METHOD constructor.
    mo_sequence = NEW #( ).
  ENDMETHOD.

  METHOD move.
    calculate_sequence_positions( it_commands ).
    go_ahead( ).
*    set_position_back_to_start( ).
*    DATA(lv_found) = scan_next_square( ).
*    IF lv_found = abap_true.
*      report_obstacle_found( ).
*    ELSE.
*      go_ahead( ).
*    ENDIF.
  ENDMETHOD.

  METHOD calculate_sequence_positions.
    mo_sequence->calculate_sequence( it_commands          = it_commands
                                     is_starting_position = ms_actual_position ).
  ENDMETHOD.

  METHOD set_starting_position.
    ms_actual_position = is_position.
  ENDMETHOD.

  METHOD report_obstacle_found.

  ENDMETHOD.

  METHOD go_ahead.
    DO.
      DATA(ls_next_position) = get_next_position( ).
      IF is_end_reached( ls_next_position ).
        EXIT.
      ENDIF.
      ##TODO " Obstacle Scan integration
      do_step( ls_next_position ).
    ENDDO.
  ENDMETHOD.

  METHOD do_step.
    ms_actual_position = is_next_position.
  ENDMETHOD.

  METHOD get_next_position .
    r_result = mo_sequence->get_next_position( ).
  ENDMETHOD.

  METHOD get_position.
    rs_position = ms_actual_position.
  ENDMETHOD.


  METHOD is_end_reached.
    rv_is_not_reached = xsdbool( is_next_position = ms_actual_position ).
  ENDMETHOD.

ENDCLASS.
