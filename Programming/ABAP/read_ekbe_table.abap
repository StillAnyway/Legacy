report Zhello2002.
tables: EKBE.

types: begin of itab,

MANDT type EKBE-MANDT,
EBELN type EKBE-EBELN,
BELNR type EKBE-BELNR,
BUZEI type EKBE-BUZEI,

end of itab.

data: itab_table type standard table of itab, itab_row type itab.

data: PO_number type STRING VALUE '4500000897', Document_number type STRING Value '5000000664'.

start-of-selection.
    select MANDT EBELN BELNR BUZEI from EKBE into table itab_table
    where EBELN = PO_number and BELNR = Document_number.
    loop at itab_table into itab_row.
        write: / 'item-num:', itab_row-BUZEI.
        skip.
    endloop.
end-of-selection.

* SEND itab_table using REST API

* Validation Criterion:
* 1st Column PO Number
* 2nd COlumn Material (based on description of invoice)
* 3rd Quantity
* 4th Price/Unit
* 5th Amount

* If mismatch on any field, block invoice for that particular field for reverification
*
*

* From where to get GRN?
* 
