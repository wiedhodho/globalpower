<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Auth extends CI_Controller {

	private $site_config;
	private $halaman = 'login';

	function __construct() {
		parent::__construct();
		$s = $this->setting->getAll();
		foreach ($s as $k) {
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('user');
	}

	function index() {
		if ($this->session->userdata('username')) {
			redirect('home');
		}
		$data['config'] = (object)$this->site_config;
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function login() {
		$data = $this->user->login();
		if ($data) {
			$this->session_reg($data);
			$this->user->logout($data->users_id);
			redirect('home');
		} else {
			$this->notif->info('Username / Password anda salah', 'error');
			redirect('auth');
		}
	}

	function logout() {
		$this->user->logout($this->session->userid);
		unset($_SESSION['username']);
		redirect('auth');
	}

	function session_reg($sess) {
		$data = array(
			'userid' => $sess->users_id,
			'level' => $sess->users_level,
			'nama' => $sess->users_nama,
			'username' => $sess->users_name
		);
		$this->session->set_userdata($data);
	}
}
