<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Notif {

	protected  $CI;

	function __construct(){
          // Assign the CodeIgniter super-object
          $this->CI =& get_instance();
  }

	function info($pesan='', $tipe='success', $title='Info'){
		$this->CI->session->set_flashdata('error_tipe', $tipe);
		$this->CI->session->set_flashdata('error_title', $title);
		$this->CI->session->set_flashdata('error_message', $pesan);
	}
}
