<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Satuan {

	private $s = array(
		'Buah',
		'Pcs',
		'Unit',
		'Paket',
		'Box',
		'Meter',
		'Kg',
		'Gram',
		'Botol'
	);

	private $j = array('Interior & Exterior', 'Advertising', 'Pengadaan');

	function stn($id=''){
		if($id!=='')
			return $this->s[$id];
		else
			return $this->s;
	}

	function jenis($id=''){
		if($id!=='')
			return $this->j[$id];
		else
			return $this->j;
	}
}
