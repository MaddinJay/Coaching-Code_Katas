CLASS ltcl_detector DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_obstacle_found       FOR TESTING,
      test_obstacle_not_found   FOR TESTING.
ENDCLASS.


CLASS ltcl_detector IMPLEMENTATION.

  METHOD test_obstacle_found.
    DATA(mo_cut) = NEW ycl_mr_detector( ).
    cl_abap_unit_assert=>assert_equals( exp = abap_true
                                        act = mo_cut->scan( VALUE yif_mr_types=>ts_position(
                                                                    x = 1
                                                                    y = 3 ) ) ).
  ENDMETHOD.

  METHOD test_obstacle_not_found.
    DATA(mo_cut) = NEW ycl_mr_detector( ).
    cl_abap_unit_assert=>assert_equals( exp = abap_true
                                        act = mo_cut->scan( VALUE yif_mr_types=>ts_position(
                                                                    x = 1
                                                                    y = 3 ) ) ).
  ENDMETHOD.

ENDCLASS.
