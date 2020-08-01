<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Download extends CI_Controller {

	function __construct(){
		parent::__construct();
		$this->load->model('quo');
		$this->load->model('m_spb');
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

}
