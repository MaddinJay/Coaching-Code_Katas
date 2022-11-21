CLASS ycl_mr_messanger DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS set_msg_obstacle_found IMPORTING is_position TYPE yif_mr_types=>ts_position.
    METHODS set_msg_no_obstacle_found.

    METHODS get_message            RETURNING VALUE(rv_message) TYPE string.

  PRIVATE SECTION.
    CONSTANTS mc_msg_no_obstacle_found  TYPE string VALUE 'No obstacle found.'.
    CONSTANTS mc_pretext_obstacle_found TYPE string VALUE 'Obstacle found in position'.

    DATA mv_message TYPE string.
ENDCLASS.

CLASS ycl_mr_messanger IMPLEMENTATION.

  METHOD set_msg_obstacle_found.
    mv_message = |{ mc_pretext_obstacle_found } ({ is_position-x }, { is_position-y }).|.
  ENDMETHOD.

  METHOD get_message.
    rv_message = mv_message.
  ENDMETHOD.

  METHOD set_msg_no_obstacle_found.
    mv_message = mc_msg_no_obstacle_found.
  ENDMETHOD.

ENDCLASS.
