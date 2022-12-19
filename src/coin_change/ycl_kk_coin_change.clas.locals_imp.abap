CLASS ycl_kk_amount IMPLEMENTATION.

  METHOD set_value.
    mv_amount = iv_amount.
  ENDMETHOD.

  METHOD get_value.
    rv_amount = mv_amount.
  ENDMETHOD.

  METHOD is_value_disible_by_coin.
    rv_is_divisible = xsdbool( mv_amount >= iv_coin ).
  ENDMETHOD.

  METHOD set_rest_value_after_change.
    mv_amount = mv_amount - iv_coin.
  ENDMETHOD.

ENDCLASS.
