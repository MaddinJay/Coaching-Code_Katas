CLASS ycl_kk_amount DEFINITION.

  PUBLIC SECTION.
    METHODS set_value IMPORTING iv_amount TYPE yif_kk_data_pool=>ty_amount.
    METHODS get_value
      RETURNING
        VALUE(rv_amount) TYPE yif_kk_data_pool=>ty_amount.

  PRIVATE SECTION.
    DATA mv_amount TYPE yif_kk_data_pool=>ty_amount.

ENDCLASS.
