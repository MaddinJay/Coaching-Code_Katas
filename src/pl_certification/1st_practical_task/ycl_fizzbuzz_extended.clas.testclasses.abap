CLASS ltcl_fizzbuzz_extended DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_fizzbuzz_extended.

    METHODS:
      accecptance_test_div_by_3 FOR TESTING,
      setup.
ENDCLASS.


CLASS ltcl_fizzbuzz_extended IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD accecptance_test_div_by_3.
    cl_abap_unit_assert=>assert_equals( exp = 'Fizz' act = mo_cut->compute( 3 ) ).
  ENDMETHOD.

ENDCLASS.
