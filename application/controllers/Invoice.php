<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Invoice extends CI_Controller {

	private $site_config;
	private $halaman = 'invoice';

	function __construct() {
		parent::__construct();
		if ($this->session->userdata('username') == FALSE) {
			redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach ($s as $k) {
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('inv');
	}

	function add() {
		$this->load->model('quo');
		$data['halaman'] = array('invoice/belum' => 'Invoice', 'invoice/add' => 'Tambah Invoice');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll(3);
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$this->parser->parse($this->halaman . '/list_quo', $data);
	}

	function buat($id) {
		$this->load->model('quo');
		$data['halaman'] = array('invoice/belum' => 'Invoice', 'invoice/add' => 'Tambah Invoice', 'buat' => 'Buat Invoice');
		$data['config'] = (object)$this->site_config;
		$data['jenis'] = $this->satuan->jenis();
		$data['quo'] = $this->quo->getById($id);
		$data['items'] = $this->quo->getItemsById($id);
		$data['satuan'] = $this->satuan->stn();
		$this->parser->parse($this->halaman . '/add', $data);
	}

	function belum() {
		$data['halaman'] = array('invoice/belum' => 'Invoice', 'belum' => 'Invoice Belum Dibayar');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->inv->getAll(2, '', '<');
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function sudah() {
		$data['halaman'] = array('invoice/belum' => 'Invoice', 'selesai' => 'Invoice Selesai');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->inv->getAll(2);
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$this->parser->parse($this->halaman . '/sudah', $data);
	}

	function save() {
		$this->load->model('quo');
		$this->db->trans_begin();
		$nomor = $this->inv->getLast() + 1;
		$id = $this->inv->add($nomor);
		$this->quo->update_status($this->input->post('id'), 4);

		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			$this->notif->info('Invoice gagal ditambahkan', 'error');
		} else {
			$this->db->trans_commit();
			$this->notif->info('Invoice berhasil ditambahkan');
		}

		redirect('invoice/belum');
	}

	function proses($id, $q) {
		$this->load->model('quo');
		$this->db->trans_begin();
		$id = $this->inv->update_status($id, 2);
		$this->quo->update_status($q, 6);
		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			$this->notif->info('Invoice gagal dibayar', 'error');
		} else {
			$this->db->trans_commit();
			$this->notif->info('Invoice berhasil dibayar');
		}

		redirect('invoice/belum');
	}

	function simpan() {
		$this->load->model('quo');
		$this->db->trans_begin();
		$this->inv->update_po();
		$this->quo->update_status($this->input->post('quo'), 3);
		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			echo 'error';
		} else {
			$this->db->trans_commit();
			echo 'sukses';
		}
	}

	function edit($id) {
		$this->load->model('quo');
		$data['halaman'] = array('invoice/belum' => 'Invoice', 'invoice/edit' => 'Edit Invoice');
		$data['config'] = (object)$this->site_config;
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['quo'] = $this->inv->getById($id);
		$data['items'] = $this->quo->getItemsById($data['quo']->inv_quo);
		$this->parser->parse($this->halaman . '/edit', $data);
	}

	function update() {
		if ($this->inv->update())
			$this->notif->info('Invoice berhasil diupdate');
		else
			$this->notif->info('Invoice gagal diupdate', 'error');

		redirect('invoice/belum');
	}

	function delete($id) {
		if ($this->inv->delete($id))
			$this->notif->info('Invoice berhasil dihapus');
		else
			$this->notif->info('Invoice gagal dihapus', 'error');
		redirect('invoice/belum');
	}

	function download($id) {
		$this->load->library('pdf');
		$this->load->model('quo');
		$this->load->library('ciqrcode');
		$data['config'] = (object)$this->site_config;
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['spb'] = $this->inv->getById($id);
		$data['items'] = $this->quo->getItemsById($data['spb']->inv_quo);
		$params['data'] = base_url() . 'download/invoice/' . urlencode(base64_encode(json_encode($data['spb']->inv_id)));
		//$params['data'] = 'base64_encode(json_encode($data))';
		$params['level'] = 'L';
		$params['size'] = 3;
		$params['savename'] = './hasil/inv_' . $this->session->userid . '.png';
		$this->ciqrcode->generate($params);

		// $this->load->view('invoice', $data);
		$this->pdf->load_view('invoice', $data);

		$this->pdf->set_paper("A4");
		$this->pdf->render();
		$this->pdf->stream('INV_' . $data['spb']->inv_nomor . '.pdf');
	}
}
