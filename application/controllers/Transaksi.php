<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Transaksi extends CI_Controller {

	private $site_config;
	private $halaman = 'transaksi';

	function __construct() {
		parent::__construct();
		if ($this->session->userdata('username') == FALSE) {
			redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach ($s as $k) {
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('quo');
	}

	function index() {
		$data['halaman'] = array('transaksi' => 'Transaksi');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll(">0");
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function detail($id) {
		$this->load->model('m_spb');
		$this->load->model('inv');
		$data['halaman'] = array('transaksi' => 'Transaksi', 'detail' => 'Detail');
		$data['config'] = (object)$this->site_config;
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$data['trans'] = $this->quo->getById($id);
		$data['spb'] = $this->m_spb->getByQuoId($id);
		$data['inv'] = $this->inv->getByQuoId($id);
		$this->parser->parse($this->halaman . '/detail', $data);
	}

	function proses() {
		$data['halaman'] = array('transaksi' => 'Transaksi', 'proses' => 'Proses');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll('1&2');
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function selesai() {
		$data['halaman'] = array('transaksi' => 'Transaksi', 'selesai' => 'selesai');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll('3&4');
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function update_status() {
		$this->quo->update_status($this->input->post('id'), $this->input->post('status'));
		if ($this->input->post('status') > 3) {
			$this->load->model('inv');
			$this->inv->update_status($this->input->post('id'), $this->input->post('status') - 4, 'quo');
		}
		redirect('transaksi/detail/' . $this->input->post('id'));
	}

	function dibayar() {
		$data['halaman'] = array('transaksi' => 'Transaksi', 'dibayar' => 'Dibayar');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll(5);
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function history($id) {
		$warna = $this->satuan->warna1();
		$status = $this->satuan->status();
		$hist = $this->quo->getHistory($id);
		$data = '
		<table class="table">
			<thead>
				<tr>
					<th>No</th>
					<th>User</th>
					<th>Status</th>
					<th>Waktu</th>
				</tr>
			</thead>
			<tbody>
		';
		$no = 1;
		foreach ($hist as $h) {
			$data .= '
				<tr>
					<td>' . $no++ . '</td>
					<td>' . $h->history_user . '</td>
					<td><small class="badge badge-' . $warna[$h->history_status] . '">' . $status[$h->history_status] . '</small></td>
					<td>' . $h->history_lastupdate . '</td>
				</tr>
			';
		}
		$data .= '
			</tbody>
		</table>
		';
		echo $data;
	}
}
