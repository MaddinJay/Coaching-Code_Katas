CLASS ycl_roman_numerals DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS convert
      IMPORTING
        iv_number         TYPE int2
      RETURNING
        VALUE(rv_romanic) TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_roman_numerals IMPLEMENTATION.

  METHOD convert.
    rv_romanic = 'I'.
  ENDMETHOD.

ENDCLASS.
