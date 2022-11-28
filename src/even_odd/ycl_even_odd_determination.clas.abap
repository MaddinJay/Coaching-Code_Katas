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
    IF xsdbool( iv_number MOD 2 = 0 ) = abap_true.
      rv_state = 'EVEN'.
      RETURN.
    ENDIF.
    IF xsdbool( iv_number MOD 1 = 0 ) = abap_true.
      rv_state = 'ODD'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
