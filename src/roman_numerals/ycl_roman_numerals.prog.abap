*&---------------------------------------------------------------------*
*& Report ycl_roman_numerals
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ycl_roman_numerals.

PARAMETERS: p_number TYPE int2.

START-OF-SELECTION.

  DATA(mo_roman_numerals) = NEW ycl_roman_numerals( ).

  DATA(lv_result) = mo_roman_numerals->convert( p_number ).

  WRITE lv_result.
