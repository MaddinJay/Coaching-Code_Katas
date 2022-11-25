CLASS ltcl_roman_numerals DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      intial_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_roman_numerals IMPLEMENTATION.

  METHOD intial_test.
    DATA mo_cut TYPE REF TO ycl_roman_numerals.
    mo_cut = NEW #( ).
    cl_abap_unit_assert=>assert_equals( exp = 'I' act = mo_cut->convert( 1 ) ).
  ENDMETHOD.

ENDCLASS.
