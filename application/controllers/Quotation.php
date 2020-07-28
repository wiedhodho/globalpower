<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Quotation extends CI_Controller {

	private $site_config;
	private $halaman='quotation';

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
	}

	function index(){
		$data['halaman'] = array('quotation' =>'Quotation');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll();
		$this->parser->parse($this->halaman.'/index', $data);
	}

	function add(){
		$this->load->model('cust');
		$data['halaman'] = array('quotation' => 'Quotation', 'add'=>'Tambah Quotation');
		$data['config'] = (object)$this->site_config;
		$data['cust'] = $this->cust->getAll();
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$this->parser->parse($this->halaman.'/add', $data);
	}

	function save(){
		// print_r($_POST);
		$this->db->trans_begin();
		$nomor = $this->quo->getLast()+1;
		$id = $this->quo->add($nomor);
		foreach($this->input->post('desc') as $k => $v){
			$data[] = array(
				'items_quo' => $id,
				'items_desc' => $v,
				'items_qty' => $this->input->post('qty')[$k],
				'items_satuan' => $this->input->post('satuan')[$k],
				'items_price' => $this->input->post('price')[$k]
			);
		}
		$this->quo->add_batch_items($data);
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$this->notif->info('Quotation gagal ditambahkan', 'error');
		} else {
			$this->db->trans_commit();
			$this->notif->info('Quotation berhasil ditambahkan');
		}

		redirect('quotation');
	}

	function edit($id){
		$data['halaman'] = array('quotation' => 'Quotation', 'edit'=>'Edit Quotation');
		$data['quo'] = $this->quo->getById($id);
		$data['config'] = (object)$this->site_config;
		$this->parser->parse($this->halaman.'/edit', $data);
	}

	function update(){
		if($this->quo->update())
			$this->notif->info('Quotation berhasil diupdate');
		else
			$this->notif->info('Quotation gagal diupdate', 'error');
		redirect('quotation');
	}

	function delete($id){
		if($this->quo->delete($id))
			$this->notif->info('Quotation berhasil dihapus');
		else
			$this->notif->info('Quotation gagal dihapus', 'error');
		redirect('quotation');
	}

}
