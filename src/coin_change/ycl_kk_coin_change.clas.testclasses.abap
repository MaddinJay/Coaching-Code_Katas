CLASS ltcl_coin_change DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO ycl_kk_coin_change.
    METHODS:
      setup,
      " Min Boundary 1 rappen
      change_1_rappen  FOR TESTING,
      " Test with all coins
      change_989_rappen FOR TESTING RAISING cx_static_check,
      " Max Boundary 999 rappen
      change_999_rappen FOR TESTING RAISING cx_static_check.
ENDCLASS.

CLASS ltcl_coin_change IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD change_1_rappen.
    cl_abap_unit_assert=>assert_initial( mo_cut->change( 1 ) ).
  ENDMETHOD.

  METHOD change_989_rappen.
    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_kk_coin_change=>tt_coins( ( coin = 500 )
                                                                                  ( coin = 200 )
                                                                                  ( coin = 200 )
                                                                                  ( coin = 50 )
                                                                                  ( coin = 20 )
                                                                                  ( coin = 10 )
                                                                                  ( coin = 5 ) )
                                        act = mo_cut->change( 989 ) ).
  ENDMETHOD.

  METHOD change_999_rappen.
    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_kk_coin_change=>tt_coins( ( coin = 500 )
                                                                                  ( coin = 200 )
                                                                                  ( coin = 200 )
                                                                                  ( coin = 50 )
                                                                                  ( coin = 20 )
                                                                                  ( coin = 20 )
                                                                                  ( coin = 5 ) )
                                        act = mo_cut->change( 999 ) ).
  ENDMETHOD.

ENDCLASS.
