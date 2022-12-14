CLASS ycl_fizzbuzz_extended DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS compute IMPORTING iv_number        TYPE int4
                    RETURNING VALUE(rv_result) TYPE string.
  PRIVATE SECTION.
    CONSTANTS mc_fizz TYPE string VALUE 'Fizz' ##NO_TEXT.
    CONSTANTS mc_buzz TYPE string VALUE 'Buzz' ##NO_TEXT.

    METHODS is_divisible_by_3 IMPORTING iv_number              TYPE int4
                              RETURNING VALUE(rv_is_divisible) TYPE abap_bool.
    METHODS is_divisible_by_5 IMPORTING iv_number              TYPE int4
                              RETURNING VALUE(rv_is_divisible) TYPE abap_bool.

ENDCLASS.

CLASS ycl_fizzbuzz_extended IMPLEMENTATION.

  METHOD compute.
    IF is_divisible_by_3( iv_number ) = abap_true.
      rv_result = mc_fizz.
    ENDIF.

    IF is_divisible_by_5( iv_number ) = abap_true.
      rv_result = mc_buzz.
    ENDIF.
  ENDMETHOD.

  METHOD is_divisible_by_5.
    rv_is_divisible = boolc( iv_number MOD 5 = 0 ).
  ENDMETHOD.

  METHOD is_divisible_by_3.
    rv_is_divisible = boolc( iv_number MOD 3 = 0 ).
  ENDMETHOD.

ENDCLASS.
