CLASS ltcl_fizzbuzz_extended DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_fizzbuzz_extended.

    METHODS:
      setup,
      acceptance_test_number_else FOR TESTING,
      acceptance_test_div_by_3 FOR TESTING,
      acceptance_test_div_by_5 FOR TESTING,
      acceptance_test_div_by_15 FOR TESTING.

    ##TODO " Boundaries testen (Right B.C.E.P. and Zombies)
    ##TODO " Anwendung IODA / Software Cell
ENDCLASS.


CLASS ltcl_fizzbuzz_extended IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD acceptance_test_div_by_3.
    cl_abap_unit_assert=>assert_equals( exp = 'Fizz' act = mo_cut->compute( 3 ) ).
  ENDMETHOD.

  METHOD acceptance_test_div_by_5.
    cl_abap_unit_assert=>assert_equals( exp = 'Buzz' act = mo_cut->compute( 5 ) ).
  ENDMETHOD.

  METHOD acceptance_test_div_by_15.
    cl_abap_unit_assert=>assert_equals( exp = 'FizzBuzz' act = mo_cut->compute( 15 ) ).
  ENDMETHOD.

  METHOD acceptance_test_number_else.
    DATA lv_result TYPE string.

    lv_result = 1.

    cl_abap_unit_assert=>assert_equals( exp = lv_result act = mo_cut->compute( 1 ) ).
  ENDMETHOD.

ENDCLASS.
