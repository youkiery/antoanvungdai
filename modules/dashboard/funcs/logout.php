<?php

if (!defined('NV_IS_MOD_NEWS')) {
  exit('Stop!!!');
}

unset($_SESSION['session']);
header('location: /login');