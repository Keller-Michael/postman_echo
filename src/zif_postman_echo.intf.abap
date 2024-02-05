INTERFACE zif_postman_echo PUBLIC.

  METHODS test_get
    IMPORTING
      query_string_parameters TYPE if_web_http_request=>name_value_pairs OPTIONAL
    RETURNING
      VALUE(result)           TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS test_post_raw_text
    IMPORTING
      json          TYPE string OPTIONAL
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS test_basic_auth
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

ENDINTERFACE.
