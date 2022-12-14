CLASS ycl_fizzbuzz_extended DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS compute IMPORTING iv_number        TYPE int4
                    RETURNING VALUE(rv_result) TYPE string.
  PRIVATE SECTION.
    CONSTANTS mc_fizz TYPE string VALUE 'Fizz' ##NO_TEXT.

ENDCLASS.

CLASS ycl_fizzbuzz_extended IMPLEMENTATION.

  METHOD compute.
    rv_result = mc_fizz.
  ENDMETHOD.

ENDCLASS.
