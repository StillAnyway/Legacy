REPORT zhelloworld2002.
TABLES: kna1.

PARAMETERS ktokd TYPE kna1-ktokd.

DATA kunnr TYPE kna1-kunnr.

START-OF-SELECTION.
  DATA Object1 TYPE REF TO cmd_ei_api.
  CREATE OBJECT Object1.
  CALL METHOD object1->get_number
    EXPORTING
      iv_ktokd = ktokd
    IMPORTING
      ev_kunnr = kunnr.
  WRITE: / kunnr.
