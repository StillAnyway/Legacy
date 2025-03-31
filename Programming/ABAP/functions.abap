* Functions can have 4 types of parameters
*     1. import
*     2. export
*     3. changing
*     4. tables
* each need to be added through the GUI in the function declaration page (Tcode: SE37)

FUNCTION myfunction2002.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(NAME) TYPE  STRING
*"     REFERENCE(AGE) TYPE  I
*"  EXPORTING
*"     REFERENCE(GREETING) TYPE  STRING
*"  CHANGING
*"     REFERENCE(COLOR) TYPE  STRING
*"----------------------------------------------------------------------
  WRITE: / 'my function 2002', name.

  color = 'Green'.

  CONCATENATE 'HI' name INTO greeting SEPARATED BY space.

ENDFUNCTION.

* ------------------------------------------------------------
* BELOW IS CALLING THE FUNCTION IN A SEPARATE FILE

REPORT zhello2002.

DATA name TYPE string VALUE 'Carl'.
DATA color TYPE string VALUE 'blue'.
DATA age TYPE i VALUE 10.
DATA greeting TYPE string VALUE 'g'.
DATA:lr_error TYPE REF TO cx_root.

TRY.
    CALL FUNCTION 'MYFUNCTION2002'
      EXPORTING
        name     = name
        age      = age
      IMPORTING
        greeting = greeting
      CHANGING
        color    = color.
    WRITE: / 'Function executed'.
  CATCH cx_root INTO lr_error.
ENDTRY.

WRITE: / color, greeting.

* ------------------------------------------------------------
