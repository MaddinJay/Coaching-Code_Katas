CLASS ltcl_fizzbuzz_extended DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_fizzbuzz_extended.

    METHODS:
      setup,
      acceptance_test_div_by_3 FOR TESTING,
      scaf_test_divide_6 FOR TESTING.
ENDCLASS.


CLASS ltcl_fizzbuzz_extended IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD acceptance_test_div_by_3.
    cl_abap_unit_assert=>assert_equals( exp = 'Fizz' act = mo_cut->compute( 3 ) ).
  ENDMETHOD.

  METHOD scaf_test_divide_6.
    cl_abap_unit_assert=>assert_equals( exp = 'Fizz' act = mo_cut->compute( 6 ) ).
  ENDMETHOD.

ENDCLASS.
