CLASS ycl_kk_amount DEFINITION.

  PUBLIC SECTION.
    METHODS set_value IMPORTING iv_amount        TYPE yif_kk_data_pool=>ty_amount.
    METHODS get_value RETURNING VALUE(rv_amount) TYPE yif_kk_data_pool=>ty_amount.

    METHODS is_value_disible_by_coin IMPORTING iv_coin                TYPE yif_kk_data_pool=>ty_coin
                                     RETURNING VALUE(rv_is_divisible) TYPE abap_bool.
    METHODS set_rest_value_after_change
      IMPORTING
        iv_coin TYPE i.

  PRIVATE SECTION.
    DATA mv_amount TYPE yif_kk_data_pool=>ty_amount.

ENDCLASS.
