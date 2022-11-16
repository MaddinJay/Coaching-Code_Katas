CLASS ltcl_mars_rover DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_mars_rover.

    METHODS:
      setup,
      " WHEN move forward/backward THEN position Y moves 1 down/up
      test_move_forward                 FOR TESTING,
      test_move_backward                FOR TESTING,
      " WHEN move forward (north) and boundary reached THEN set x postition to 1
      test_move_forw_edge_reached     FOR TESTING,
      " WHEN move forward (south) and boundary reached THEN set x postition to 4
      test_move_backw_edge_reached    FOR TESTING,
      " WHEN move left/right THEN position Y moved 1 down/up
      test_move_left                    FOR TESTING,
      test_move_right                   FOR TESTING,
      " WHEN move left (west) and boundary reached THEN set y postition to 4
      test_move_left_edge_reached        FOR TESTING,
      " WHEN move right (east) and boundary reached THEN set y postition to 1
      test_move_right_edge_reached       FOR TESTING,

      test_move_by_command_sequence FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_mars_rover IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).

  ENDMETHOD.

  METHOD test_move_forward.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = 2 ) ).

    " Move Mars rover forward (direction north)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-north ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = 1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_backward.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = 2 ) ).

    " Move Mars rover forward (direction south)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-south ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = 3 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_forw_edge_reached.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = 1 ) ).

    " Move Mars rover forward (direction north)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-north ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = 2 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_backw_edge_reached.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = 4 ) ).

    " Move Mars rover forward (direction south)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-south ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = 3 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_left.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 2 y = 1 ) ).

    " Move Mars rover left (direction west)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-west ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = 1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_right.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = 1 ) ).

    " Move Mars rover right (direction east)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-east ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 2 y = 1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_left_edge_reached.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 1 y = 1 ) ).

    " Move Mars rover left (direction west)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-west ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 4 y = 1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_right_edge_reached.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 4 y = 1 ) ).

    " Move Mars rover left (direction east)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-east ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 1 y = 1 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_move_by_command_sequence.
    " Set the starting position
    mo_cut->set_starting_position( VALUE ycl_mars_rover=>ts_position( x = 2 y = 2 ) ).

    " Move Mars rover left (direction east)
    mo_cut->move( VALUE ycl_mars_rover=>tt_commands( ( ycl_mars_rover=>mc_direction-north )
                                                     ( ycl_mars_rover=>mc_direction-east )
                                                     ( ycl_mars_rover=>mc_direction-south )
                                                     ( ycl_mars_rover=>mc_direction-west ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 2 y = 2 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

ENDCLASS.
