INTERFACE yif_mr_types
  PUBLIC .
  TYPES: ty_position TYPE int1,
         BEGIN OF ts_position,
           x TYPE ty_position,
           y TYPE ty_position,
         END OF ts_position,
         tt_position TYPE STANDARD TABLE OF ts_position WITH DEFAULT KEY,

         BEGIN OF ENUM ty_direction STRUCTURE mc_direction BASE TYPE char1,
           no_direction VALUE IS INITIAL,
           north        VALUE 'N',
           south        VALUE 'S',
           west         VALUE 'W',
           east         VALUE 'E',
         END OF ENUM ty_direction STRUCTURE mc_direction,
         tt_commands TYPE STANDARD TABLE OF ty_direction WITH DEFAULT KEY.
ENDINTERFACE.
