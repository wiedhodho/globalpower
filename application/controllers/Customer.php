<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Customer extends CI_Controller {

	private $site_config;
	private $halaman='customer';

	function __construct(){
		parent::__construct();
		// if($this->session->userdata('username')==FALSE){
		// 		redirect('/auth');
		// }
		$s = $this->setting->getAll();
		foreach($s as $k){
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('cust');
	}

	function index(){
		$data['halaman'] = array('customer' =>'Customer');
		$data['config'] = (object)$this->site_config;
		$data['cust'] = $this->cust->getAll();
		$this->parser->parse($this->halaman.'/index', $data);
	}

	function add(){
		$data['halaman'] = array('customer' => 'Customer', 'add'=>'Tambah Customer');
		$data['config'] = (object)$this->site_config;
		$this->parser->parse($this->halaman.'/add', $data);
	}

	function save(){
		if($this->cust->add())
			$this->notif->info('Customer berhasil ditambahkan');
		else
			$this->notif->info('Customer gagal ditambahkan', 'error');
		redirect('customer');
	}

	function edit($id){
		$data['halaman'] = array('customer' => 'Customer', 'edit'=>'Edit Customer');
		$data['cust'] = $this->cust->getById($id);
		$data['config'] = (object)$this->site_config;
		$this->parser->parse($this->halaman.'/edit', $data);
	}

	function update(){
		if($this->cust->update())
			$this->notif->info('Customer berhasil diupdate');
		else
			$this->notif->info('Customer gagal diupdate', 'error');
		redirect('customer');
	}

	function delete($id){
		if($this->cust->delete($id))
			$this->notif->info('Customer berhasil dihapus');
		else
			$this->notif->info('Customer gagal dihapus', 'error');
		redirect('customer');
	}

}
