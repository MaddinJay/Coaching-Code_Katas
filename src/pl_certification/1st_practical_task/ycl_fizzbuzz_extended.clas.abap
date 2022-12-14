CLASS ycl_fizzbuzz_extended DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! Computes for positive numbers the Fizz/Buzz string
    "! For numbers:
    "!  - Divisible by 3 -> Fizz
    "!  - Divisible by 5 -> Buzz
    "!  - Divisible by 3 and 5 -> FizzBuzz
    "! @parameter iv_number | Numbers, positive INT4
    "! @parameter rv_result | String
    METHODS compute IMPORTING iv_number        TYPE int4
                    RETURNING VALUE(rv_result) TYPE string.
  PRIVATE SECTION.
    CONSTANTS mc_fizz TYPE string VALUE 'Fizz' ##NO_TEXT.
    CONSTANTS mc_buzz TYPE string VALUE 'Buzz' ##NO_TEXT.
    CONSTANTS mc_fizzbuzz TYPE string VALUE 'FizzBuzz' ##NO_TEXT.

    METHODS is_divisible_by_3 IMPORTING iv_number              TYPE int4
                              RETURNING VALUE(rv_is_divisible) TYPE abap_bool.
    METHODS is_divisible_by_5 IMPORTING iv_number              TYPE int4
                              RETURNING VALUE(rv_is_divisible) TYPE abap_bool.

ENDCLASS.

CLASS ycl_fizzbuzz_extended IMPLEMENTATION.

  METHOD compute.
    rv_result = COND #( WHEN is_divisible_by_3( iv_number ) AND is_divisible_by_5( iv_number )  THEN mc_fizzbuzz
                        WHEN is_divisible_by_3( iv_number )                                     THEN mc_fizz
                        WHEN is_divisible_by_5( iv_number )                                     THEN mc_buzz
                        ELSE iv_number ).
  ENDMETHOD.

  METHOD is_divisible_by_5.
    rv_is_divisible = boolc( iv_number MOD 5 = 0 ).
  ENDMETHOD.

  METHOD is_divisible_by_3.
    rv_is_divisible = boolc( iv_number MOD 3 = 0 ).
  ENDMETHOD.

ENDCLASS.
