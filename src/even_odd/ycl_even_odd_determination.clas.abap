CLASS ycl_even_odd_determination DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS determine
      IMPORTING
        iv_number       TYPE int4
      RETURNING
        VALUE(rv_state) TYPE char4.
  PRIVATE SECTION.
ENDCLASS.

CLASS ycl_even_odd_determination IMPLEMENTATION.

  METHOD determine.
    rv_state = 'ODD'.
  ENDMETHOD.

ENDCLASS.
