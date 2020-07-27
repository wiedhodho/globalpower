<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Users extends CI_Controller {

	private $site_config;
	private $halaman='users';
	private $level = array('Super Admin', 'Marketing', 'Ekspeditor', 'Kasir');

	function __construct(){
		parent::__construct();
		if($this->session->userdata('username')==FALSE){
				redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach($s as $k){
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('user');
	}

	function index(){
		$data['halaman'] = array('users' => 'Users');
		$data['user'] = $this->user->getAll();
		$data['config'] = (object)$this->site_config;
		$data['level'] = $this->level;
		$this->parser->parse($this->halaman.'/index', $data);
	}

	function profile(){
		$data['halaman'] = 'Profil Saya';
		$data['config'] = (object)$this->site_config;
		$data['user'] = $this->user->getById($this->session->userid);
		$this->parser->parse($this->halaman.'/profil', $data);
	}

	function salahlogin(){
		$data['halaman'] = 'Salah Login';
		$data['user'] = $this->user->getAllSalah();
		$data['config'] = (object)$this->site_config;
		$this->parser->parse($this->halaman.'/salah_login', $data);
	}

	function add(){
		$data['halaman'] = array('users' => 'Users', 'add'=>'Tambah User');
		$data['config'] = (object)$this->site_config;
		$data['level'] = $this->level;
		$this->parser->parse($this->halaman.'/add', $data);
	}

	function save(){
		// $config['upload_path'] = './foto_pegawai/';
    // $config['allowed_types'] = 'jpg|png|jpeg|bmp';
    // $this->load->library('upload', $config);
		$sukses = TRUE;
		$foto='';
		//
		// if($_FILES['foto']['size']>0){
		// 	if($this->upload->do_upload('foto')){
		// 		$foto = $this->upload->data()['file_name'];
		// 		$sukses = TRUE;
		// 	} else {
		// 		$sukses = FALSE;
		// 		$this->notif('Data gagal ditambahkan<br />'.$this->upload->display_errors(), 'error');
		// 	}
		// }
		if($sukses){
			if($this->user->add($foto))
				$this->notif->info('Data Berhasil Ditambahkan');
			else
				$this->notif->info('Data Gagal Ditambahkan', 'error');
		}
		redirect($this->halaman);
	}

	function edit($id){
		$data['halaman'] = array('users' => 'Users', 'edit'=>'Edit User');
		$data['config'] = (object)$this->site_config;
		$data['user'] = $this->user->getById($id);
		$data['level'] = $this->level;
		$this->parser->parse($this->halaman.'/edit', $data);
	}

	function update(){
		// $config['upload_path'] = './foto_pegawai/';
    // $config['allowed_types'] = 'jpg|png|jpeg|bmp';
    // $this->load->library('upload', $config);
		$sukses = TRUE;
		$foto='';

		// if($_FILES['foto']['size']>0){
		// 	if($this->upload->do_upload('foto')){
		// 		$foto = $this->upload->data()['file_name'];
		// 	} else {
		// 		$sukses = FALSE;
		// 		$this->notif('Data gagal ditambahkan<br />'.$this->upload->display_errors(), 'error');
		// 	}
		// }

		if($sukses){
			if($this->user->update($foto))
				$this->notif->info('Data Berhasil Diupdate ');
			else
				$this->notif->info('Data Gagal Diupdate', 'error');
		}
		redirect($this->halaman);
	}

	function update_profil(){
		$config['upload_path'] = './foto_pegawai/';
    $config['allowed_types'] = 'jpg|png|jpeg|bmp';
    $this->load->library('upload', $config);
		$sukses = TRUE;
		$foto='';

		if($_FILES['foto']['size']>0){
			if($this->upload->do_upload('foto')){
				$foto = $this->upload->data()['file_name'];
			} else {
				$sukses = FALSE;
				$this->notif('Data gagal ditambahkan<br />'.$this->upload->display_errors(), 'error');
			}
		}

		if($sukses){
			if($this->user->update_profil($foto))
				$this->notif('Data Berhasil Diupdate ');
			else
				$this->notif('Data Gagal Diupdate', 'error');
		}
		redirect($this->halaman.'/profile');
	}

	function delete($id){
		if($this->user->delete($id))
			$this->notif('Data Berhasil Dihapus');
		else
			$this->notif('Data Gagal Dihapus', 'error');
		redirect($this->halaman);
	}

	protected function notif($pesan='', $tipe='success', $title='Info'){
		$this->session->set_flashdata('error_tipe', $tipe);
		$this->session->set_flashdata('error_title', $title);
		$this->session->set_flashdata('error_message', $pesan);
	}
}
