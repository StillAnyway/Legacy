REPORT zhello2002.
TABLES: ekbe.

DATA: PO_number       TYPE ekbe-ebeln VALUE '4500000897', Document_number TYPE string VALUE '5000000664'.
DATA:lr_error TYPE REF TO cx_root.


TYPES: BEGIN OF itab,

         mandt TYPE ekbe-mandt,
         ebeln TYPE ekbe-ebeln,
         belnr TYPE ekbe-belnr,
         buzei TYPE ekbe-buzei,

       END OF itab.
DATA itab_row TYPE itab.

TRY.

    DATA: po_items TYPE TABLE OF bapiekpo WITH HEADER LINE.

    CALL FUNCTION 'BAPI_PO_GETDETAIL'
      EXPORTING
        purchaseorder      = po_number
        items              = 'X'
        account_assignment = ' '
        schedules          = ' '
        history            = ' '
        item_texts         = ' '
        header_texts       = ' '
        services           = ' '
        confirmations      = ' '
        service_texts      = ' '
        extensions         = ' '
      TABLES
        po_items           = po_items.


    CHECK sy-subrc = 0.
    LOOP AT po_items INTO itab_row.
      WRITE: / 'item-num:', itab_row-buzei.
      SKIP.
    ENDLOOP.


  CATCH cx_root INTO lr_error.
ENDTRY.
