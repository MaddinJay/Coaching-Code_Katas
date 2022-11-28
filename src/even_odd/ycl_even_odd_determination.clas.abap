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
    METHODS is_even
      IMPORTING
        iv_number         TYPE int4
      RETURNING
        VALUE(rv_is_even) TYPE abap_bool.
    METHODS is_odd
      IMPORTING
        iv_number       TYPE int4
      RETURNING
        VALUE(r_result) TYPE xsdboolean.
ENDCLASS.



CLASS ycl_even_odd_determination IMPLEMENTATION.


  METHOD determine.
    IF is_even( iv_number ).
      rv_state = 'EVEN'.
      RETURN.
    ENDIF.

    IF is_odd( iv_number ) = abap_true.
      rv_state = 'ODD'.
    ENDIF.
  ENDMETHOD.

  METHOD is_odd.
    r_result = xsdbool( iv_number MOD 1 = 0 ).
  ENDMETHOD.

  METHOD is_even.
    rv_is_even = xsdbool( iv_number MOD 2 = 0 ).
  ENDMETHOD.
ENDCLASS.
