<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Bulan {

	private $b = array('Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des');

	function bln($id=''){
		if($id!=='')
			return $this->b[$id];
		else
			return $this->b;
	}
}
