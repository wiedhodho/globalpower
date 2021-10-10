<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Rekapinv extends CI_Controller {

	private $site_config;
	private $halaman = 'rekap';

	function __construct() {
		parent::__construct();
		if ($this->session->userdata('username') == FALSE) {
			redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach ($s as $k) {
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('rekap');
	}

	function index() {
		$data['halaman'] = array('rekapinv' => 'Rekap', 'belum' => 'Rekap Invoice');
		$data['config'] = (object)$this->site_config;
		$data['rekap'] = $this->rekap->getAll();
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function add() {
		$this->load->model('inv');
		$data['halaman'] = array('rekapinv/add' => 'Rekap', 'belum' => 'Add');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->inv->getAllBelum();
		$this->parser->parse($this->halaman . '/add1', $data);
	}

	function add2($cust_id) {
		$this->load->model('inv');
		$data['halaman'] = array('rekapinv/add' => 'Rekap', 'belum' => 'Add');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->inv->getAll(0, $cust_id);
		$this->parser->parse($this->halaman . '/add2', $data);
	}

	function save() {
		$this->load->model('inv');
		$inv = array_keys($this->input->post('inv'));
		$total = $this->inv->getTotal($inv);
		$this->rekap->add($total->inv_customer, implode(',', $inv), $total->total);
		$this->inv->update_status($inv, 1);
		$this->notif->info('Rekap berhasil dibuat');
		redirect('rekapinv');
	}

	function delete($id) {
		$inv_id = $this->rekap->getById($id);
		if ($this->rekap->delete($id)) {
			$this->load->model('inv');
			$this->inv->update_status(explode(',', $inv_id->rekap_invoice), 0);
			$this->notif->info('Rekap berhasil dihapus');
		} else
			$this->notif->info('Rekap gagal dihapus', 'error');
		redirect('rekapinv');
	}
}
