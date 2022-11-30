CLASS ycl_mastermind DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_row,
             place_one TYPE string,
           END OF ts_row,
           BEGIN OF ts_counting,
             correct      TYPE int1,
             wrong_placed TYPE int1,
           END OF ts_counting.
    METHODS constructor IMPORTING is_row_to_guess TYPE ts_row.
    METHODS evaluate
      IMPORTING
        is_row          TYPE ts_row
      RETURNING
        VALUE(r_result) TYPE ts_counting.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA ms_row TYPE ts_row.
ENDCLASS.

CLASS ycl_mastermind IMPLEMENTATION.

  METHOD constructor.
    ms_row = is_row_to_guess.
  ENDMETHOD.

  METHOD evaluate.
    DO 5 TIMES.
      r_result = VALUE #( correct = 1 ).
    ENDDO.
  ENDMETHOD.
ENDCLASS.
