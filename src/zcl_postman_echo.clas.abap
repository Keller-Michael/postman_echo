CLASS zcl_postman_echo DEFINITION PUBLIC FINAL CREATE PRIVATE.

  PUBLIC SECTION.
    INTERFACES zif_postman_echo.

    CLASS-METHODS create
      RETURNING
        VALUE(result) TYPE REF TO zif_postman_echo
      RAISING
        zcx_postman_echo.

    METHODS constructor RAISING zcx_postman_echo.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA http_client TYPE REF TO if_web_http_client.

    METHODS create_http_client RAISING zcx_postman_echo.

ENDCLASS.



CLASS zcl_postman_echo IMPLEMENTATION.

  METHOD constructor.
    create_http_client( ).
  ENDMETHOD.

  METHOD create.
    result = NEW zcl_postman_echo( ).
  ENDMETHOD.

  METHOD zif_postman_echo~get.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/get' ).

    TRY.
        IF query_pairs IS NOT INITIAL.
          http_request->set_form_fields( query_pairs ).
        ENDIF.

        result = http_client->execute( if_web_http_client=>get ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD create_http_client.
    TRY.
        DATA(http_destination) = cl_http_destination_provider=>create_by_url( 'https://postman-echo.com' ).
        http_client = cl_web_http_client_manager=>create_by_http_destination( http_destination ).
      CATCH cx_web_message_error INTO DATA(message_error).
        RAISE EXCEPTION NEW zcx_postman_echo( ).
      CATCH cx_http_dest_provider_error INTO DATA(destination_provider_error).
        RAISE EXCEPTION NEW zcx_postman_echo( ).
      CATCH cx_web_http_client_error INTO DATA(http_client_error).
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~post.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/post' ).
    http_request->set_content_type( 'application/json' ).

    TRY.
        IF query_pairs IS NOT INITIAL.
          http_request->set_form_fields( query_pairs ).
        ENDIF.

        IF json IS NOT INITIAL.
          http_request->set_text( json ).
        ENDIF.

        result = http_client->execute( if_web_http_client=>post ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~basic_auth.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/basic-auth' ).

    TRY.
        http_request->set_authorization_basic( i_username = 'postman'
                                               i_password = 'password' ).

        result = http_client->execute( if_web_http_client=>get ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~put.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/put' ).
    http_request->set_content_type( 'application/json' ).

    TRY.
        IF query_pairs IS NOT INITIAL.
          http_request->set_form_fields( query_pairs ).
        ENDIF.

        IF json IS NOT INITIAL.
          http_request->set_text( json ).
        ENDIF.

        result = http_client->execute( if_web_http_client=>put ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~patch.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/patch' ).
    http_request->set_content_type( 'application/json' ).

    TRY.
        IF query_pairs IS NOT INITIAL.
          http_request->set_form_fields( query_pairs ).
        ENDIF.

        IF json IS NOT INITIAL.
          http_request->set_text( json ).
        ENDIF.

        result = http_client->execute( if_web_http_client=>patch ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~delete.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/delete' ).
    http_request->set_content_type( 'application/json' ).

    TRY.
        IF query_pairs IS NOT INITIAL.
          http_request->set_form_fields( query_pairs ).
        ENDIF.

        IF json IS NOT INITIAL.
          http_request->set_text( json ).
        ENDIF.

        result = http_client->execute( if_web_http_client=>delete ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~get_current_utc_time.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/time/now' ).

    TRY.
        result = http_client->execute( if_web_http_client=>get ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~get_ip_address.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/ip' ).

    TRY.
        result = http_client->execute( if_web_http_client=>get ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_postman_echo~validate_timestamp.
    DATA(http_request) = http_client->get_http_request(  ).
    http_request->set_uri_path( i_uri_path = '/time/valid' ).

    TRY.
        http_request->set_form_field( i_name  = 'timestamp'
                                      i_value = timestamp ).

        http_request->set_form_field( i_name  = 'format'
                                      i_value = format ).

        result = http_client->execute( if_web_http_client=>get ).
      CATCH cx_web_message_error
            cx_web_http_client_error.
        RAISE EXCEPTION NEW zcx_postman_echo( ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
