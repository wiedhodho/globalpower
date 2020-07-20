<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings extends CI_Controller {

	private $site_config;
	private $halaman='setting/';

	function __construct(){
		parent::__construct();
		if($this->session->userdata('username')==FALSE){
				redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach($s as $k){
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('setting');
	}

	function index(){
		$data['halaman'] = 'Setting';
		$data['setting'] = $this->setting->getAll();
		$data['config'] = (object)$this->site_config;
		$this->load->model('news');
		$data['highlights'] = $this->news->getAll(5);
		$this->parser->parse($this->halaman.'index', $data);
	}

	function edit($id){
		$data['halaman'] = 'Edit Setting';
		$data['config'] = (object)$this->site_config;
		$data['setting'] = $this->setting->getById($id);
		$this->parser->parse($this->halaman.'edit', $data);
	}

	function update(){
		if($this->setting->update())
			$this->notif('Data Berhasil Diupdate');
		else
			$this->notif('Data Gagal Diupdate', 'error');
		redirect('settings');
	}

	function delete($id){
		if($this->setting->delete($id))
			$this->notif('Data Berhasil Dihapus');
		else
			$this->notif('Data Gagal Dihapus', 'error');
		redirect('setting');
	}

	protected function notif($pesan='', $tipe='success', $title='Info'){
		$this->session->set_flashdata('error_tipe', $tipe);
		$this->session->set_flashdata('error_title', $title);
		$this->session->set_flashdata('error_message', $pesan);
	}
}
