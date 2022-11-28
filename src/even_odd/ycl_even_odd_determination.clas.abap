CLASS ycl_even_odd_determination DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    "! Determines the state of a number, EVEN or ODD
    "! For even numbers we get result EVEN
    "! For odd numbers we get result ODD
    "! Range number is INT4: -2,147,483,648 to +2,147,483,647
    "! @parameter iv_number | Number
    "! @parameter rv_state | State of number (EVEN/ODD)
    METHODS determine IMPORTING iv_number       TYPE int4
                      RETURNING VALUE(rv_state) TYPE char4.

  PRIVATE SECTION.
    CONSTANTS even TYPE string VALUE 'EVEN' ##NO_TEXT.
    CONSTANTS odd TYPE string VALUE 'ODD' ##NO_TEXT.
    METHODS is_even IMPORTING iv_number         TYPE int4
                    RETURNING VALUE(rv_is_even) TYPE abap_bool.
    METHODS is_odd  IMPORTING iv_number        TYPE int4
                    RETURNING VALUE(rv_is_odd) TYPE xsdboolean.
ENDCLASS.

CLASS ycl_even_odd_determination IMPLEMENTATION.

  METHOD determine.
    rv_state = COND #( WHEN is_even( iv_number ) THEN even
                       WHEN is_odd( iv_number )  THEN odd ).
  ENDMETHOD.

  METHOD is_odd.
    rv_is_odd  = xsdbool( iv_number MOD 1 = 0 ).
  ENDMETHOD.

  METHOD is_even.
    rv_is_even = xsdbool( iv_number MOD 2 = 0 ).
  ENDMETHOD.

ENDCLASS.
