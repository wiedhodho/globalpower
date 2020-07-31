<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

require_once APPPATH.'/third_party/xls/PHPExcel/IOFactory.php';

class Excel {

    public $xls;

    function __construct($params) {
        $objReader = PHPExcel_IOFactory::createReader('Excel2007');

        $this->xls = $objReader->load(APPPATH.'/libraries/templates/'.$params[0].'.xlsx');
    }
}
