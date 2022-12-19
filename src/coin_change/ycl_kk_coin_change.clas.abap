CLASS ycl_kk_coin_change DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor.

    METHODS change IMPORTING iv_amount       TYPE yif_kk_data_pool=>ty_amount
                   RETURNING VALUE(rt_coins) TYPE yif_kk_data_pool=>tt_coins.


  PRIVATE SECTION.
    DATA mt_coins   TYPE yif_kk_data_pool=>tt_coins.
    DATA mo_amount TYPE REF TO ycl_kk_amount.

    METHODS change_with_coin        IMPORTING iv_coin                         TYPE int4
                                    RETURNING VALUE(rv_is_changeable_by_coin) TYPE abap_bool.
    METHODS build_list_of_coins     RETURNING VALUE(rt_coins) TYPE int4_table.
    METHODS change_with_actual_coin IMPORTING iv_coin TYPE any.
    METHODS add_coin_to_change_list IMPORTING iv_coin TYPE int4.
    METHODS set_rest_value_after_change IMPORTING iv_coin TYPE int4.
    METHODS mark_as_changeable          RETURNING VALUE(rv_is_changeable_by_coin) TYPE abap_bool.
ENDCLASS.


CLASS ycl_kk_coin_change IMPLEMENTATION.

  METHOD constructor.
    mo_amount = NEW #( ).
  ENDMETHOD.

  METHOD change.
    mo_amount->set_value( iv_amount ).

    ##TODO " Generalisierung für unterschiedliche Währungen integrieren mit bsp.weise Command Pattern und Factory Pattern
    LOOP AT build_list_of_coins( ) INTO DATA(lv_coin).
      change_with_actual_coin( lv_coin ).
    ENDLOOP.

    rt_coins = mt_coins.
  ENDMETHOD.

  METHOD change_with_actual_coin.
    DATA lv_is_changeable_by_coin TYPE abap_bool VALUE abap_true.

    WHILE lv_is_changeable_by_coin = abap_true.   " As long amount is bigger than actual coin amount
      lv_is_changeable_by_coin = change_with_coin( iv_coin ).
    ENDWHILE.
  ENDMETHOD.

  METHOD build_list_of_coins.
    ##TODO " Geht es auch ohne Konvertierung?
    rt_coins  = VALUE int4_table( ( CONV #( yif_kk_data_pool=>mc_coins-five_francs ) )
                                  ( CONV #( yif_kk_data_pool=>mc_coins-two_francs ) )
                                  ( CONV #( yif_kk_data_pool=>mc_coins-one_franc ) )
                                  ( CONV #( yif_kk_data_pool=>mc_coins-fifty_rappen ) )
                                  ( CONV #( yif_kk_data_pool=>mc_coins-twenty_rappen ) )
                                  ( CONV #( yif_kk_data_pool=>mc_coins-ten_rappen ) )
                                  ( CONV #( yif_kk_data_pool=>mc_coins-five_rappen ) ) ).
  ENDMETHOD.

  METHOD change_with_coin.
    IF mo_amount->is_value_disible_by_coin( iv_coin ).
      add_coin_to_change_list( iv_coin ).
      set_rest_value_after_change( iv_coin ).
      rv_is_changeable_by_coin = mark_as_changeable( ).
    ENDIF.
  ENDMETHOD.

  METHOD mark_as_changeable.
    rv_is_changeable_by_coin = abap_true.
  ENDMETHOD.

  METHOD set_rest_value_after_change.
    mo_amount->set_rest_value_after_change( iv_coin ).
  ENDMETHOD.

  METHOD add_coin_to_change_list.
    APPEND VALUE yif_kk_data_pool=>ts_coin( coin = iv_coin ) TO mt_coins.
  ENDMETHOD.

ENDCLASS.
