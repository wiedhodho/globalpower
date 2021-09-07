<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Satuan {

	private $s = array(
		'Buah',
		'Batang',
		'Box',
		'Botol',
		'Bucket',
		'Ikat',
		'Koli',
		'Lusin',
		'Gram',
		'Kg',
		'Lbr',
		'Meter',
		'M3',
		'Pcs',
		'Paket',
		'Unit',
		'Zak',
		'Ret',
		'Kaleng',
		'Hole',
	);

	private $j = array('Interior & Exterior', 'Advertising', 'Pengadaan');
	private $w = array('info', 'danger', 'success', 'warning');
	private $w1 = array('danger', 'warning', 'info', 'secondary', 4 => 'success', 'primary');
	private $s1 = array(-1 => 'Batal', 0 => 'Quotation', 1 => 'Proses', 2 => 'Dikirim', 3 => 'Terkirim', 4 => 'Invoice', 5 => 'Dibayar');

	function stn($id = '') {
		if ($id !== '')
			return $this->s[$id];
		else
			return $this->s;
	}

	function jenis($id = '') {
		if ($id !== '')
			return $this->j[$id];
		else
			return $this->j;
	}

	function warna($id = '') {
		if ($id !== '')
			return $this->w[$id];
		else
			return $this->w;
	}

	function warna1($id = '') {
		if ($id !== '')
			return $this->w1[$id];
		else
			return $this->w1;
	}

	function status($id = '') {
		if ($id !== '')
			return $this->s1[$id];
		else
			return $this->s1;
	}
}
