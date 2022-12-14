CLASS ycl_fizzbuzz_extended DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS compute IMPORTING iv_number        TYPE int4
                    RETURNING VALUE(rv_result) TYPE string.
  PRIVATE SECTION.
    CONSTANTS mc_fizz TYPE string VALUE 'Fizz' ##NO_TEXT.
    METHODS is_divisible_by_3 IMPORTING iv_number       TYPE int4
                              RETURNING VALUE(r_result) TYPE abap_bool.

ENDCLASS.

CLASS ycl_fizzbuzz_extended IMPLEMENTATION.

  METHOD compute.
    IF is_divisible_by_3( iv_number ) = abap_true.
      rv_result = mc_fizz.
    ENDIF.
  ENDMETHOD.

  METHOD is_divisible_by_3.
    r_result = boolc( iv_number MOD 3 = 0 ).
  ENDMETHOD.

ENDCLASS.
