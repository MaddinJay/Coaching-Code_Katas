CLASS ycl_mars_rover DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS set_starting_position   IMPORTING is_position TYPE yif_mr_types=>ts_position.

    METHODS move IMPORTING it_commands TYPE yif_mr_types=>tt_commands.

    METHODS constructor.
    METHODS get_position RETURNING VALUE(rs_position) TYPE yif_mr_types=>ts_position.
    METHODS get_message  RETURNING VALUE(rv_message) TYPE string.

  PRIVATE SECTION.
    DATA ms_actual_position TYPE yif_mr_types=>ts_position.
    DATA mo_sequence        TYPE REF TO ycl_mr_position_sequence.
    DATA mo_scanner         TYPE REF TO ycl_mr_detector.
    DATA mo_message         TYPE REF TO ycl_mr_messanger.

    METHODS calculate_sequence              IMPORTING it_commands TYPE yif_mr_types=>tt_commands.

    METHODS execute_sequence.
    METHODS get_next_position               RETURNING VALUE(r_result)          TYPE yif_mr_types=>ts_position.
    METHODS is_end_reached                  IMPORTING is_next_position         TYPE yif_mr_types=>ts_position
                                            RETURNING VALUE(rv_is_not_reached) TYPE abap_bool.
    METHODS do_step                         IMPORTING is_next_position         TYPE yif_mr_types=>ts_position.
    METHODS is_obstacle_found               IMPORTING is_position        TYPE yif_mr_types=>ts_position
                                            RETURNING VALUE(rv_is_found) TYPE abap_bool.
    METHODS report_obstacle                 IMPORTING is_position              TYPE yif_mr_types=>ts_position.
    METHODS report_no_obstacle_found.

ENDCLASS.

CLASS ycl_mars_rover IMPLEMENTATION.

  METHOD calculate_sequence.
    mo_sequence->calculate_sequence( it_commands          = it_commands
                                     is_starting_position = ms_actual_position ).
  ENDMETHOD.

  METHOD constructor.
    mo_sequence = NEW #( ).
    mo_scanner  = NEW #( ). ##TODO " Break dependency for testing by DIP
    mo_message  = NEW #( ). ##TODO " Break dependency for testing by DIP
  ENDMETHOD.

  METHOD do_step.
    ms_actual_position = is_next_position.
  ENDMETHOD.

  METHOD execute_sequence.
    DO.
      DATA(ls_next_position) = get_next_position( ).

      IF is_end_reached( ls_next_position ).
        report_no_obstacle_found( ).
        EXIT.   " Stop in final position of sequence
      ENDIF.

      IF is_obstacle_found( ls_next_position ).
        report_obstacle( ls_next_position ).
        EXIT.   " Stop in actual position
      ELSE.
        do_step( ls_next_position ).
      ENDIF.
    ENDDO.
  ENDMETHOD.

  METHOD get_message.
    rv_message = mo_message->get_message( ).
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

  METHOD is_obstacle_found.
    rv_is_found = mo_scanner->scan( is_position ).
  ENDMETHOD.

  METHOD move.
    calculate_sequence( it_commands ).
    execute_sequence( ).
  ENDMETHOD.

  METHOD report_no_obstacle_found.
    mo_message->set_msg_no_obstacle_found( ).
  ENDMETHOD.

  METHOD report_obstacle.
    mo_message->set_msg_obstacle_found( is_position ).
  ENDMETHOD.

  METHOD set_starting_position.
    ms_actual_position = is_position.
  ENDMETHOD.

ENDCLASS.
