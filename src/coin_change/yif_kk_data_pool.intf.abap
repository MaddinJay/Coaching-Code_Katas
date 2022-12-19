INTERFACE yif_kk_data_pool
  PUBLIC .
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
  TYPES: ty_amount TYPE int2.
  CONSTANTS: mc_minimal_coin TYPE ty_coin VALUE 5.
ENDINTERFACE.
