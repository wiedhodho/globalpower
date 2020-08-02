<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Download extends CI_Controller {

	private $site_config;

	function __construct(){
		parent::__construct();
		$s = $this->setting->getAll();
		foreach($s as $k){
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('quo');
		$this->load->model('m_spb');
		$this->load->model('inv');
	}

	function spb($id){
		$id = json_decode(base64_decode(urldecode($id)));
		$this->load->library('pdf');
		$this->load->model('quo');
		$this->load->library('ciqrcode');
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['spb'] = $this->m_spb->getById($id);
		$data['items'] = $this->quo->getItemsById($data['spb']->spb_quo);
		$params['data'] = base_url().'download/spb/'.urlencode(base64_encode(json_encode($data['spb']->spb_id)));
		$params['level'] = 'L';
		$params['size'] = 3;
		$params['savename'] = './hasil/barcode_'.$this->session->userid.'.png';
		$this->ciqrcode->generate($params);

		$this->pdf->load_view('spb', $data);

		$this->pdf->set_paper("A6", 'landscape');
		$this->pdf->render();
		$this->pdf->stream('SPB_'.$data['spb']->spb_nomor.'.pdf');
	}

	function invoice($id){
		$id = json_decode(base64_decode(urldecode($id)));
		$this->load->library('pdf');
		$this->load->model('quo');
		$this->load->library('ciqrcode');
		$data['config'] = (object)$this->site_config;
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['spb'] = $this->inv->getById($id);
		$data['items'] = $this->quo->getItemsById($data['spb']->inv_quo);
		$params['data'] = base_url().'download/invoice/'.urlencode(base64_encode(json_encode($data['spb']->inv_id)));
		//$params['data'] = 'base64_encode(json_encode($data))';
		$params['level'] = 'L';
		$params['size'] = 3;
		$params['savename'] = './hasil/inv_'.$this->session->userid.'.png';
		$this->ciqrcode->generate($params);

		// $this->load->view('invoice', $data);
		$this->pdf->load_view('invoice', $data);

		$this->pdf->set_paper("A4");
		$this->pdf->render();
		$this->pdf->stream('INV_'.$data['spb']->inv_nomor.'.pdf');
	}

}
