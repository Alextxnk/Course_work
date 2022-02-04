<?php

   define ('SITE_NAME', "Furniture store"); //константа
   define ('ERR_NAME', "Furniture store - 404 Not found");
   define('HOST', "http://" . $_SERVER['HTTP_HOST']);

   define('DB_HOST', '127.0.0.1'); //const DB_HOST = '127.0.0.1'; //localhost
   define('DB_NAME', 'furniture');
   define('DB_USER', 'root');
   define('DB_PASS', '');
   define('URL_CHARS', "abcdefghijklmnopqrstuvwxyz0123456789-");

   session_start();
