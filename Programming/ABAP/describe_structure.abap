REPORT zHello2002.
** Add the name of the Table Here
DATA: ls_struct TYPE TABLE_NAME.

DATA:
  lr_structdescr     TYPE REF TO cl_abap_structdescr,
  lr_datadescr       TYPE REF TO cl_abap_datadescr,
  lr_datadescr_incl  TYPE REF TO cl_abap_datadescr,
  lt_components      TYPE abap_component_tab,
  ls_components      TYPE LINE OF abap_component_tab,
  lt_components_incl TYPE abap_component_tab,
  ls_components_incl TYPE LINE OF abap_component_tab.

* now decribe the LS_STRUCT structure
lr_structdescr ?= cl_abap_structdescr=>describe_by_data( ls_struct ).
lt_components = lr_structdescr->get_components( ).
LOOP AT lt_components INTO ls_components.
  lr_datadescr = ls_components-type.
  IF ls_components-as_include = space.
    WRITE:/ ls_components-name, lr_datadescr->type_kind, lr_datadescr->length.
  ELSE.  " IF include or append structure, you need to get that structures components now.
    lr_structdescr ?= ls_components-type.
    lt_components_incl = lr_structdescr->get_components( ).
    LOOP AT lt_components_incl INTO ls_components_incl.
      lr_datadescr_incl = ls_components_incl-type.
      WRITE:/ ls_components_incl-name, lr_datadescr_incl->type_kind, lr_datadescr_incl->length.
    ENDLOOP.

  ENDIF.
ENDLOOP.
