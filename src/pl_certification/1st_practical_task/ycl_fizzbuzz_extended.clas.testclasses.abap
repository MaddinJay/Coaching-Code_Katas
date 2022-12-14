CLASS ltcl_fizzbuzz_extended DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      accecptance_test_div_by_3 FOR TESTING.
ENDCLASS.


CLASS ltcl_fizzbuzz_extended IMPLEMENTATION.

  METHOD accecptance_test_div_by_3.
    DATA mo_cut TYPE REF TO ycl_fizzbuzz_extended.
    mo_cut = NEW #( ).
    cl_abap_unit_assert=>assert_equals( exp = 'Fizz' act = mo_cut->compute( 3 ) ).
  ENDMETHOD.

ENDCLASS.
