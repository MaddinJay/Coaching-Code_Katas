CLASS ltcl_roman_numerals DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_roman_numerals.

    METHODS:
      setup,
      " Acceptance Test No.1: Convert number to I
      " Is lower boundary
      convert_number_to_i FOR TESTING,
      " Boundary tests. Accept values between 1 and 3000
      test_out_of_lower_boundary FOR TESTING,
      test_upper_boundary_3000 FOR TESTING,
      test_out_of_upper_boundary FOR TESTING.

ENDCLASS.


CLASS ltcl_roman_numerals IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD convert_number_to_i.
    cl_abap_unit_assert=>assert_equals( exp = 'I' act = mo_cut->convert( 1 ) ).
  ENDMETHOD.

  METHOD test_out_of_lower_boundary.
    cl_abap_unit_assert=>assert_equals( exp = 'Conversion failed' act = mo_cut->convert( 0 ) ).
  ENDMETHOD.

  METHOD test_out_of_upper_boundary.
    cl_abap_unit_assert=>assert_equals( exp = 'Conversion failed' act = mo_cut->convert( 3001 ) ).
  ENDMETHOD.

  METHOD test_upper_boundary_3000.
    cl_abap_unit_assert=>assert_equals( exp = 'MMM' act = mo_cut->convert( 3000 ) ).
  ENDMETHOD.

ENDCLASS.
