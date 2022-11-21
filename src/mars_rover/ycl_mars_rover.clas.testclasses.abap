CLASS ltcl_mars_rover DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO ycl_mars_rover.
    DATA: new_variable TYPE abap_bool.

    METHODS:
      setup,
      test_go_one_position_ahead FOR TESTING,
      test_ended_without_found   FOR TESTING,
      test_ended_with_found FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_mars_rover IMPLEMENTATION.

  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.

  METHOD test_go_one_position_ahead.
    mo_cut->set_starting_position( VALUE #( x = 1 y = 1 ) ).

    mo_cut->move( it_commands = VALUE #( ( yif_mr_types=>mc_direction-east )
                                         ( yif_mr_types=>mc_direction-south ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE yif_mr_types=>ts_position( x = 2 y = 2 )
                                        act = mo_cut->get_position( ) ).
  ENDMETHOD.

  METHOD test_ended_without_found.
    mo_cut->set_starting_position( VALUE #( x = 1 y = 1 ) ).

    mo_cut->move( it_commands = VALUE #( ( yif_mr_types=>mc_direction-east ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = 'No obstacle found.'
                                        act = mo_cut->get_message( ) ).
  ENDMETHOD.

  METHOD test_ended_with_found.
    mo_cut->set_starting_position( VALUE #( x = 1 y = 2 ) ).

    mo_cut->move( it_commands = VALUE #( ( yif_mr_types=>mc_direction-north ) ) ).

    cl_abap_unit_assert=>assert_equals( exp = 'Obstacle found in position (1, 1).'
                                        act = mo_cut->get_message( ) ).
  ENDMETHOD.

ENDCLASS.
