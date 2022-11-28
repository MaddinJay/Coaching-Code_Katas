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
    IF iv_number = 1.
      rv_state = 'ODD'.
    ELSEIF xsdbool( iv_number MOD 2 = 0 ) = abap_true.
      rv_state = 'EVEN'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
