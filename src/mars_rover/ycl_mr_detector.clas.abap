CLASS ycl_mr_detector DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
    METHODS scan IMPORTING is_position     TYPE yif_mr_types=>ts_position
                 RETURNING VALUE(rv_found) TYPE abap_bool.

  PRIVATE SECTION.
    DATA mt_obstacle_positions TYPE yif_mr_types=>tt_position.
    METHODS set_up_obstacle_positions.
ENDCLASS.



CLASS YCL_MR_DETECTOR IMPLEMENTATION.


  METHOD constructor.
    set_up_obstacle_positions( ).
  ENDMETHOD.


  METHOD scan.
    READ TABLE mt_obstacle_positions INTO DATA(ls_position) WITH KEY x = is_position-x y = is_position-y.
    IF sy-subrc = 0.
      rv_found = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD set_up_obstacle_positions.
    mt_obstacle_positions = VALUE yif_mr_types=>tt_position(
                                        ( x = 1 y = 1 )
                                        ( x = 1 y = 3 )
                                        ( x = 3 y = 2 )
                                        ( x = 3 y = 4 ) ).
  ENDMETHOD.
ENDCLASS.
