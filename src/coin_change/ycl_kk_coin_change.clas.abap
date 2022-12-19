CLASS ycl_kk_coin_change DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_coin TYPE int4,
           BEGIN OF ts_coin,
             coin TYPE ty_coin,
           END OF ts_coin,
           tt_coins TYPE STANDARD TABLE OF ts_coin WITH DEFAULT KEY.
    TYPES: BEGIN OF ENUM coins STRUCTURE mc_coins BASE TYPE ty_coin,
             zero_rappen   VALUE IS INITIAL, " Have to be defined once
             five_rappen   VALUE 5,
             ten_rappen    VALUE 10,
             twenty_rappen VALUE 20,
             fifty_rappen  VALUE 50,
             one_franc     VALUE 100,
             two_francs    VALUE 200,
             five_francs   VALUE 500,
           END OF ENUM coins STRUCTURE mc_coins.
    CONSTANTS: mc_minimal_coin TYPE ty_coin VALUE 5.

    METHODS change IMPORTING iv_amount       TYPE ty_coin
                   RETURNING VALUE(rt_coins) TYPE ycl_kk_coin_change=>tt_coins.

  PRIVATE SECTION.
    DATA mt_coins   TYPE tt_coins.
    DATA mv_amount  TYPE ycl_kk_coin_change=>ty_coin.

    METHODS change_with_coin        IMPORTING iv_coin                         TYPE int4
                                    RETURNING VALUE(rv_is_changeable_by_coin) TYPE abap_bool.
    METHODS build_list_of_coins     RETURNING VALUE(rt_coins) TYPE int4_table.
    METHODS change_with_actual_coin IMPORTING iv_coin TYPE any.
ENDCLASS.


CLASS ycl_kk_coin_change IMPLEMENTATION.

  METHOD change.
    DATA mo_amount TYPE REF TO ycl_kk_amount.
    mo_amount = NEW #( ).
    mo_amount->set_value( iv_amount ).

    mv_amount = iv_amount.
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
    rt_coins  = VALUE int4_table( ( CONV #( mc_coins-five_francs ) )
                                  ( CONV #( mc_coins-two_francs ) )
                                  ( CONV #( mc_coins-one_franc ) )
                                  ( CONV #( mc_coins-fifty_rappen ) )
                                  ( CONV #( mc_coins-twenty_rappen ) )
                                  ( CONV #( mc_coins-ten_rappen ) )
                                  ( CONV #( mc_coins-five_rappen ) ) ).
  ENDMETHOD.

  METHOD change_with_coin.
    IF mv_amount >= iv_coin.
      APPEND VALUE ts_coin( coin = iv_coin ) TO mt_coins. " Store coin for output
      mv_amount                = mv_amount - iv_coin.     " Reduce amount by coin value
      rv_is_changeable_by_coin = abap_true.               " Mark to repeat change with this coin
    ENDIF.
  ENDMETHOD.

ENDCLASS.
