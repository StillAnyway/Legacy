REPORT zhelloworld2002.
TABLES: bapiret2.

DATA:
  ls_master_data                 TYPE cmds_ei_main,
  returner_correct_master_data   TYPE cmds_ei_main,
  returner_defective_master_data TYPE cmds_ei_main,
  ls_customer_extern             TYPE cmds_ei_extern,
  ls_customer_ei_header          TYPE cmds_ei_header,
  ls_custormer_ei_central_data   TYPE cmds_ei_central_data,
  ls_customer_central            TYPE cmds_ei_cmd_central,
  ls_customer_central_data       TYPE cmds_ei_vmd_central_data,
  ls_customer_addr               TYPE cvis_ei_address1,
  ls_customer_addr_postal        TYPE cvis_ei_1vl,
  ls_customer_addr_postal_data   TYPE bapiad1vl.

PARAMETERS name TYPE STRING.

ls_customer_central_data-psovn = 'Ben'.
ls_customer_central_data-pson1 = 'BEN'.
ls_customer_central_data-pson2 = 'Jackson'.
ls_customer_central_data-psost = 'Jane Street'.
ls_customer_central_data-psotl = 'Mr.'.
ls_customer_central_data-ktokd = '0003'.

ls_customer_addr_postal_data-postl_cod1 = '47892'.
ls_customer_addr_postal_data-name = name.
ls_customer_addr_postal_data-city = 'San Marino'.
ls_customer_addr_postal_data-langu = 'EN'.
ls_customer_addr_postal_data-country = 'SM'.

ls_customer_ei_header-object_task = 'I'.

ls_customer_central-data = ls_customer_central_data.
ls_custormer_ei_central_data-central = ls_customer_central.

ls_customer_addr_postal-data = ls_customer_addr_postal_data.
ls_customer_addr-postal = ls_customer_addr_postal.
ls_custormer_ei_central_data-address = ls_customer_addr.

ls_customer_extern-header = ls_customer_ei_header.
ls_customer_extern-central_data = ls_custormer_ei_central_data.
* ls_master_data-customers = ls_customer_extern.
APPEND ls_customer_extern TO ls_master_data-customers.

DATA correct_message TYPE CVIS_Message.
DATA wrong_message TYPE CVIS_Message.


DATA Object1 TYPE REF TO cmd_ei_api.
CREATE OBJECT Object1.
CALL METHOD object1->maintain_bapi
  EXPORTING
    is_master_data           = ls_master_data
  IMPORTING
    es_message_correct       = correct_message
    es_message_defective     = wrong_message
    es_master_data_correct   = returner_correct_master_data
    es_master_data_defective = returner_defective_master_data.
WRITE: / 'Object created:', wrong_message-is_error.
SKIP.
WRITE: / 'Correct message:', correct_message-is_error.

TYPES: BEGIN OF itab,

         message   TYPE bapiret2-message,
         parameter TYPE bapiret2-parameter,

       END OF itab.

DATA itab_row TYPE itab.

LOOP AT wrong_message-messages INTO itab_row.
  WRITE: / itab_row-message, itab_row-parameter.
  SKIP.
ENDLOOP.

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'.
