REPORT zhelloworld2002.
DATA : wa_address TYPE bapicustomer_04.

PARAMETERS p_kunnr TYPE kunnr.

CALL FUNCTION 'BAPI_CUSTOMER_GETDETAIL2'
  EXPORTING
    customerno      = p_kunnr
  IMPORTING
    customeraddress = wa_address.

WRITE: wa_address-name , wa_address-name_2 , wa_address-city , wa_address-country.
