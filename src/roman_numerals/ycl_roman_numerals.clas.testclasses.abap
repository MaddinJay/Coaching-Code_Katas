CLASS ltcl_roman_numerals DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_roman_numerals.

    METHODS:
      setup,
      " Acceptance Test No.1: Convert number to I
      convert_number_to_i FOR TESTING.

ENDCLASS.


CLASS ltcl_roman_numerals IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD convert_number_to_i.
    cl_abap_unit_assert=>assert_equals( exp = 'I' act = mo_cut->convert( 1 ) ).
  ENDMETHOD.

ENDCLASS.
