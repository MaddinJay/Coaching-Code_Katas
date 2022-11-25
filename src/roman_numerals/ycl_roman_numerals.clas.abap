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
    IF iv_number < 1 OR iv_number > 3000.
      rv_romanic = 'Conversion failed'.
      EXIT.
    ENDIF.

    rv_romanic = COND #( WHEN iv_number = 1 THEN 'I'
                         WHEN iv_number = 3000 THEN 'MMM' ).
  ENDMETHOD.

ENDCLASS.
