CLASS ltcl_mars_rover DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_mars_rover.

    METHODS:
      setup,
      " WHEN given starting point THEN starting point is set in object
      test_setting_starting_point FOR TESTING,
      " WHEN receiving direction THEN direction is set in object
      test_receive_direction      FOR TESTING.

ENDCLASS.

CLASS ltcl_mars_rover IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).

  ENDMETHOD.

  METHOD test_setting_starting_point.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = -1 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = -1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_receive_direction.
    " Receive the direction
    mo_cut->set_direction( is_direction = VALUE #( north = 1 east = -1 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_direction( north = 1 east = -1 )
                                        act = mo_cut->get_direction( ) ).
  ENDMETHOD.

ENDCLASS.
