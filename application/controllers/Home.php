<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {

	private $site_config;
	private $halaman='dashboard';

	function __construct(){
		parent::__construct();
		// if($this->session->userdata('username')==FALSE){
		// 		redirect('/auth');
		// }
		$s = $this->setting->getAll();
		foreach($s as $k){
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		// $this->load->model('news');
	}

	function index(){
		$data['halaman'] = 'Dashboard';
		$data['config'] = (object)$this->site_config;

		$this->parser->parse($this->halaman.'/index', $data);
	}
}
