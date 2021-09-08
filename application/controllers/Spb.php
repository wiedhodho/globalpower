<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Spb extends CI_Controller {

	private $site_config;
	private $halaman = 'spb';

	function __construct() {
		parent::__construct();
		if ($this->session->userdata('username') == FALSE) {
			redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach ($s as $k) {
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('m_spb');
	}

	function add() {
		$this->load->model('quo');
		$data['halaman'] = array('spb/proses' => 'Spb', 'spb/add' => 'Tambah Spb');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll(1);
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$this->parser->parse($this->halaman . '/list_quo', $data);
	}

	function buat($id) {
		$this->load->model('quo');
		$data['halaman'] = array('spb/proses' => 'Spb', 'spb/add' => 'Tambah Spb', 'buat' => 'Buat Spb');
		$data['config'] = (object)$this->site_config;
		$data['jenis'] = $this->satuan->jenis();
		$data['quo'] = $this->quo->getById($id);
		$data['items'] = $this->quo->getItemsById($id);
		$data['satuan'] = $this->satuan->stn();
		$this->parser->parse($this->halaman . '/add', $data);
	}

	function proses() {
		$data['halaman'] = array('spb/proses' => 'Spb', 'proses' => 'SPB Dikirim');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->m_spb->getAll();
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$this->parser->parse($this->halaman . '/index', $data);
	}

	function selesai() {
		$data['halaman'] = array('spb/proses' => 'Spb', 'selesai' => 'SPB Selesai');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->m_spb->getAll('ok');
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$this->parser->parse($this->halaman . '/selesai', $data);
	}

	function save() {
		$this->load->model('quo');
		$this->db->trans_begin();
		$nomor = $this->m_spb->getLast() + 1;
		$id = $this->m_spb->add($nomor);
		$this->quo->update_status($this->input->post('id'), 2);

		if ($this->db->trans_status() === FALSE) {
			$this->db->trans_rollback();
			$this->notif->info('Spb gagal ditambahkan', 'error');
		} else {
			$this->db->trans_commit();
			$this->notif->info('Spb berhasil ditambahkan');
		}

		redirect('spb/proses');
	}

	function simpan() {
		$this->load->model('quo');
		$this->db->trans_begin();
		$this->m_spb->update_po();
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
		$data['halaman'] = array('spb/proses' => 'Spb', 'spb/edit' => 'Edit Spb');
		$data['config'] = (object)$this->site_config;
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['spb'] = $this->m_spb->getById($id);
		$data['items'] = $this->quo->getItemsById($data['spb']->spb_quo);
		$this->parser->parse($this->halaman . '/edit', $data);
	}

	function update() {
		if ($this->m_spb->update())
			$this->notif->info('Spb berhasil diupdate');
		else
			$this->notif->info('Spb gagal diupdate', 'error');

		redirect('spb/proses');
	}

	function delete($id) {
		if ($this->m_spb->delete($id))
			$this->notif->info('Spb berhasil dihapus');
		else
			$this->notif->info('Spb gagal dihapus', 'error');
		redirect('spb/proses');
	}

	function download($id) {
		$this->load->library('pdf');
		$this->load->model('quo');
		$this->load->library('ciqrcode');
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['spb'] = $this->m_spb->getById($id);
		$data['items'] = $this->quo->getItemsById($data['spb']->spb_quo);
		$params['data'] = base_url() . 'download/spb/' . urlencode(base64_encode(json_encode($data['spb']->spb_id)));
		//$params['data'] = 'base64_encode(json_encode($data))';
		$params['level'] = 'L';
		$params['size'] = 3;
		$params['savename'] = './hasil/barcode_' . $this->session->userid . '.png';
		$this->ciqrcode->generate($params);

		// $this->load->view('spb', $data);
		$this->pdf->load_view('spb', $data);

		$this->pdf->set_paper("A6", 'landscape');
		$this->pdf->render();
		$this->pdf->stream('SPB_' . $data['spb']->spb_nomor . '.pdf');
	}
}
