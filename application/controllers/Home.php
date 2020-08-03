<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {

	private $site_config;
	private $halaman='dashboard';

	function __construct(){
		parent::__construct();
		if($this->session->userdata('username')==FALSE){
				redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach($s as $k){
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('quo');
		$this->load->model('cust');
	}

	function index(){
		$data['halaman'] = 'Dashboard';
		$data['config'] = (object)$this->site_config;
		$data['interior'] = $this->quo->countAll(0);
		$data['adv'] = $this->quo->countAll(1);
		$data['pengadaan'] = $this->quo->countAll(2);
		$data['cust'] = $this->cust->countAll();
		$data['bulan'] = $this->bulan->bln();
		$data['total_rupiah'] = $data['interior']->total + $data['adv']->total + $data['pengadaan']->total;
		if($data['total_rupiah']>1000000){
			$data['total_rupiah'] = $data['total_rupiah'] / 1000000;
			$data['pembagi'] = 1000000;
			$data['dalam'] = 'juta rupiah';
		} else if($data['total_rupiah']>1000){
			$data['total_rupiah'] = $data['total_rupiah'] / 1000;
			$data['pembagi'] = 1000;
			$data['dalam'] = 'ribu rupiah';
		}
		$data['per_bulan'] = $this->quo->countByBulan(date('Y'));
		// print_r($data['per_bulan']);
		$this->parser->parse($this->halaman.'/index', $data);
	}
}
