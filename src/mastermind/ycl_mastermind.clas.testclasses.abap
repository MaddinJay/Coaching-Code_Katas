CLASS ltcl_mastermind DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      acceptance_test_all_correct FOR TESTING,
      correct_guess FOR TESTING.
ENDCLASS.


CLASS ltcl_mastermind IMPLEMENTATION.

  METHOD acceptance_test_all_correct.

    DATA mo_cut TYPE REF TO ycl_mastermind.
    mo_cut = NEW #( VALUE ycl_mastermind=>ts_row( place_one = 'GREEN' ) ).
    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mastermind=>ts_counting( correct = 1 wrong_placed = 0 )
                                        act = mo_cut->evaluate(  VALUE ycl_mastermind=>ts_row( place_one = 'GREEN' ) ) ).
  ENDMETHOD.

  METHOD correct_guess.
    DATA mo_cut TYPE REF TO ycl_mastermind.
    mo_cut = NEW #( VALUE ycl_mastermind=>ts_row( place_one = 'RED' ) ).
    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mastermind=>ts_counting( correct = 1 wrong_placed = 0 )
                                        act = mo_cut->evaluate(  VALUE ycl_mastermind=>ts_row( place_one = 'RED' ) ) ).
  ENDMETHOD.

ENDCLASS.
