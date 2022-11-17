CLASS ltcl_position_sequence DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_move_right FOR TESTING,
      test_move_right_edge_reached FOR TESTING,

      test_move_left FOR TESTING,
      test_move_left_edge_reached FOR TESTING,

      test_move_forward FOR TESTING,
      test_move_forward_edge_reached FOR TESTING,

      test_move_backward FOR TESTING,
      test_move_backw_edge_reached FOR TESTING,

      test_get_next_position FOR TESTING.
ENDCLASS.


CLASS ltcl_position_sequence IMPLEMENTATION.

  METHOD test_move_right.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-east ) )
        is_starting_position = VALUE #( x = 2 y = 2 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 2 y = 2 )
                                                                                 ( x = 3 y = 2 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_move_right_edge_reached.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-east ) )
        is_starting_position = VALUE #( x = 4 y = 2 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 4 y = 2 )
                                                                                 ( x = 1 y = 2 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_move_left.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-west ) )
        is_starting_position = VALUE #( x = 2 y = 2 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 2 y = 2 )
                                                                                 ( x = 1 y = 2 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_move_left_edge_reached.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-west ) )
        is_starting_position = VALUE #( x = 1 y = 2 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 1 y = 2 )
                                                                                 ( x = 4 y = 2 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_move_forward.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-north ) )
        is_starting_position = VALUE #( x = 2 y = 2 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 2 y = 2 )
                                                                                 ( x = 2 y = 1 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_move_forward_edge_reached.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-north ) )
        is_starting_position = VALUE #( x = 2 y = 1 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 2 y = 1 )
                                                                                 ( x = 2 y = 2 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_move_backward.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-south ) )
        is_starting_position = VALUE #( x = 2 y = 2 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 2 y = 2 )
                                                                                 ( x = 2 y = 3 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_move_backw_edge_reached.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-south ) )
        is_starting_position = VALUE #( x = 2 y = 4 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>tt_position( ( x = 2 y = 4 )
                                                                                 ( x = 2 y = 3 ) )
                                        act = mo_cut->get_sequence( )  ).
  ENDMETHOD.

  METHOD test_get_next_position.
    DATA(mo_cut) = NEW ycl_mr_postion_sequence( ).
    mo_cut->calculate_sequence(
        it_commands          = VALUE #( ( ycl_mars_rover=>mc_direction-south ) )
        is_starting_position = VALUE #( x = 2 y = 4 ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE ycl_mars_rover=>ts_position( x = 2 y = 3  )
                                        act = mo_cut->get_next_position( ) ).
  ENDMETHOD.

ENDCLASS.
