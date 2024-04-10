CLASS ltc_postman_echo DEFINITION FINAL FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES: BEGIN OF ty_json_example,
             msg_via_json TYPE string,
           END OF ty_json_example.

    CLASS-DATA json_example TYPE string.

    CLASS-DATA query_pair_example TYPE if_web_http_request=>name_value_pairs.

    CLASS-METHODS class_setup.

    METHODS put_with_json_and_query FOR TESTING RAISING zcx_postman_echo.

    METHODS post_with_json_and_query FOR TESTING RAISING zcx_postman_echo.

    METHODS patch_with_json_and_query FOR TESTING RAISING zcx_postman_echo.

    METHODS delete_with_json_and_query FOR TESTING RAISING zcx_postman_echo.

    METHODS get_ip_address FOR TESTING RAISING zcx_postman_echo.

    METHODS get_current_utc_time FOR TESTING RAISING zcx_postman_echo.

    METHODS check_valid_timestamp FOR TESTING RAISING zcx_postman_echo.

    METHODS check_timestamp_invalid_format FOR TESTING RAISING zcx_postman_echo.

ENDCLASS.


CLASS ltc_postman_echo IMPLEMENTATION.

  METHOD put_with_json_and_query.
    DATA(cut) = zcl_postman_echo=>create( ).

    DATA(response) = cut->put( query_pairs = query_pair_example
                               json        = json_example ).

    DATA(status) = response->get_status( ).

    cl_abap_unit_assert=>assert_equals( act = status-code
                                        exp = '200' ).
  ENDMETHOD.

  METHOD class_setup.
    DATA(json) = VALUE ty_json_example( msg_via_json = 'Hi there!' ).

    json_example = /ui2/cl_json=>serialize( data        = json
                                            pretty_name = /ui2/cl_json=>pretty_mode-low_case ).

    query_pair_example = VALUE if_web_http_request=>name_value_pairs( ( name = 'msg_via_parameter'
                                                                        value = 'Hello World!' ) ).
  ENDMETHOD.

  METHOD post_with_json_and_query.
    DATA(cut) = zcl_postman_echo=>create( ).

    DATA(response) = cut->post( query_pairs = query_pair_example
                                         json        = json_example ).

    DATA(status) = response->get_status( ).

    cl_abap_unit_assert=>assert_equals( act = status-code
                                        exp = '200' ).
  ENDMETHOD.

  METHOD patch_with_json_and_query.
    DATA(cut) = zcl_postman_echo=>create( ).

    DATA(response) = cut->patch( query_pairs = query_pair_example
                                 json        = json_example ).

    DATA(status) = response->get_status( ).

    cl_abap_unit_assert=>assert_equals( act = status-code
                                        exp = '200' ).
  ENDMETHOD.

  METHOD delete_with_json_and_query.
    DATA(cut) = zcl_postman_echo=>create( ).

    DATA(response) = cut->delete( ).

    DATA(status) = response->get_status( ).

    cl_abap_unit_assert=>assert_equals( act = status-code
                                        exp = '200' ).
  ENDMETHOD.

  METHOD get_current_utc_time.
    DATA(cut) = zcl_postman_echo=>create( ).

    DATA(response) = cut->get_current_utc_time( ).

    DATA(status) = response->get_status( ).

    cl_abap_unit_assert=>assert_equals( act = status-code
                                        exp = '200' ).
  ENDMETHOD.

  METHOD get_ip_address.
    DATA(cut) = zcl_postman_echo=>create( ).

    DATA(response) = cut->get_ip_address( ).

    DATA(status) = response->get_status( ).

    cl_abap_unit_assert=>assert_equals( act = status-code
                                        exp = '200' ).
  ENDMETHOD.

  METHOD check_valid_timestamp.
    TYPES: BEGIN OF ty_validation_result,
             valid TYPE abap_bool,
           END OF ty_validation_result.

    DATA validation_result TYPE ty_validation_result.

    DATA(cut) = zcl_postman_echo=>create( ).

    GET TIME STAMP FIELD DATA(timestamp).

    DATA(response) = cut->validate_timestamp( CONV #( timestamp ) ).

    /ui2/cl_json=>deserialize(
                     EXPORTING
                       json = response->get_text( )
                     CHANGING
                       data = validation_result ).

    cl_abap_unit_assert=>assert_true( validation_result-valid ).
  ENDMETHOD.

  METHOD check_timestamp_invalid_format.
    TYPES: BEGIN OF ty_validation_result,
             valid TYPE abap_bool,
           END OF ty_validation_result.

    DATA validation_result TYPE ty_validation_result.

    DATA(cut) = zcl_postman_echo=>create( ).

    GET TIME STAMP FIELD DATA(timestamp).

    DATA(response) = cut->validate_timestamp( timestamp = CONV #( timestamp )
                                              format = 'AAAABBCC' ).

    /ui2/cl_json=>deserialize(
                     EXPORTING
                       json = response->get_text( )
                     CHANGING
                       data = validation_result ).

    cl_abap_unit_assert=>assert_false( validation_result-valid ).
  ENDMETHOD.

ENDCLASS.
