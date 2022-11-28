CLASS ltcl_even_odd DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_for_1_is_odd FOR TESTING.
ENDCLASS.


CLASS ltcl_even_odd IMPLEMENTATION.

  METHOD test_for_1_is_odd.
    DATA mo_cut TYPE REF TO ycl_even_odd_determination.
    mo_cut = NEW #( ).
    cl_abap_unit_assert=>assert_equals( exp = 'ODD' act = mo_cut->determine( 1 ) ).
  ENDMETHOD.

ENDCLASS.
