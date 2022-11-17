CLASS ltcl_mars_rover DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_mars_rover.

    METHODS:
      setup,
      test_go_one_position_ahead FOR TESTING.

ENDCLASS.

CLASS ltcl_mars_rover IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD test_go_one_position_ahead.
    mo_cut->set_starting_position( VALUE #( x = 1 y = 1 ) ).

    mo_cut->move( it_commands = VALUE #( ( ycl_mars_rover=>mc_direction-east )
                                         ( ycl_mars_rover=>mc_direction-south ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 2 y = 2 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

ENDCLASS.
