INTERFACE zif_postman_echo PUBLIC.

  METHODS get
    IMPORTING
      query_pairs   TYPE if_web_http_request=>name_value_pairs OPTIONAL
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS post
    IMPORTING
      query_pairs   TYPE if_web_http_request=>name_value_pairs OPTIONAL
      json          TYPE string OPTIONAL
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS delete
    IMPORTING
      query_pairs   TYPE if_web_http_request=>name_value_pairs OPTIONAL
      json          TYPE string OPTIONAL
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS put
    IMPORTING
      query_pairs   TYPE if_web_http_request=>name_value_pairs OPTIONAL
      json          TYPE string OPTIONAL
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS patch
    IMPORTING
      query_pairs   TYPE if_web_http_request=>name_value_pairs OPTIONAL
      json          TYPE string OPTIONAL
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS basic_auth
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS get_ip_address
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS get_current_utc_time
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

  METHODS validate_timestamp
    IMPORTING
      timestamp     TYPE string
      format        TYPE string DEFAULT 'YYYYMMDDhhmmss'
    RETURNING
      VALUE(result) TYPE REF TO if_web_http_response
    RAISING
      zcx_postman_echo.

ENDINTERFACE.
