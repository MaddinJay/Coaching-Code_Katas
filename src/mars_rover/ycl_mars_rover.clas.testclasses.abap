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
      test_receive_direction      FOR TESTING,
      " WHEN receiving commands  THEN commands are set in object
      test_receive_commands FOR TESTING,

      test_move_forward FOR TESTING RAISING cx_static_check,

      test_move_backward FOR TESTING RAISING cx_static_check,
      " WHEN move forward (north) and boundary reached THEN set x postition to 1
      test_move_forw_boundary_reach FOR TESTING RAISING cx_static_check,

      test_move_backw_boundary_reach FOR TESTING RAISING cx_static_check.

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
    mo_cut->set_direction( ycl_mars_rover=>mc_direction-north ).

    cl_abap_unit_assert=>assert_equals( exp = ycl_mars_rover=>mc_direction-north
                                        act = mo_cut->get_direction( ) ).
  ENDMETHOD.

  METHOD test_receive_commands.
    " Receive the commands array
    mo_cut->set_commands( VALUE ycl_mars_rover=>tt_commands( ( |1| )
                                                             ( |-1| ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_commands( ( |1| )
                                                                                 ( |-1| ) )
                                        act = mo_cut->get_commands( ) ).
  ENDMETHOD.

  METHOD test_move_forward.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = -1 ) ).
    mo_cut->set_direction( ycl_mars_rover=>mc_direction-north ).

    " Move Mars rover forward (direction north)
    mo_cut->move_forward_backward( ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 2 y = -1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_backward.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 2 y = -1 ) ).
    mo_cut->set_direction( ycl_mars_rover=>mc_direction-south ).

    " Move Mars rover forward (direction south)
    mo_cut->move_forward_backward( ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = -1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_forw_boundary_reach.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 4 y = -1 ) ).
    mo_cut->set_direction( ycl_mars_rover=>mc_direction-north ).

    " Move Mars rover forward (direction north)
    mo_cut->move_forward_backward( ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = -1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_backw_boundary_reach.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = 4 ) ).
    mo_cut->set_direction( ycl_mars_rover=>mc_direction-south ).

    " Move Mars rover forward (direction north)
    mo_cut->move_forward_backward( ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 4 y = 4 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.
ENDCLASS.
