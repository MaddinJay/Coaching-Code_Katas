CLASS ltcl_even_odd DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_even_odd_determination.

    METHODS:
      setup,
      test_for_1_is_odd FOR TESTING,
      test_for_2_is_even FOR TESTING,
      test_for_4346_is_even FOR TESTING.
ENDCLASS.

CLASS ltcl_even_odd IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD test_for_1_is_odd.
    cl_abap_unit_assert=>assert_equals( exp = 'ODD' act = mo_cut->determine( 1 ) ).
  ENDMETHOD.

  METHOD test_for_2_is_even.
    cl_abap_unit_assert=>assert_equals( exp = 'EVEN' act = mo_cut->determine( 2 ) ).
  ENDMETHOD.

  METHOD test_for_4346_is_even.
    cl_abap_unit_assert=>assert_equals( exp = 'EVEN' act = mo_cut->determine( 4346 ) ).
  ENDMETHOD.

ENDCLASS.
