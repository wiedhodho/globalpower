<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Spb extends CI_Controller {

	private $site_config;
	private $halaman='Spb';

	function __construct(){
		parent::__construct();
		if($this->session->userdata('username')==FALSE){
				redirect('/auth');
		}
		$s = $this->setting->getAll();
		foreach($s as $k){
			$this->site_config[$k->settings_id] = $k->settings_value;
		}
		$this->load->model('m_spb');
	}

	function add(){
		$this->load->model('quo');
		$data['halaman'] = array('spb/proses' => 'Spb', 'spb/add'=>'Tambah Spb');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll(1);
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$data['warna1'] = $this->satuan->warna1();
		$data['status'] = $this->satuan->status();
		$this->parser->parse($this->halaman.'/list_quo', $data);
	}

	function buat($id){
		$this->load->model('quo');
		$data['halaman'] = array('spb/proses' => 'Spb', 'spb/add'=>'Tambah Spb', 'buat'=>'Buat Spb');
		$data['config'] = (object)$this->site_config;
		$data['jenis'] = $this->satuan->jenis();
		$data['quo'] = $this->quo->getById($id);
		$data['items'] = $this->quo->getItemsById($id);
		$data['satuan'] = $this->satuan->stn();
		$this->parser->parse($this->halaman.'/add', $data);
	}

	function proses(){
		$data['halaman'] = array('spb/proses' =>'Spb', 'proses'=>'Proses');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->m_spb->getAll();
		$this->parser->parse($this->halaman.'/index', $data);
	}

	function selesai(){
		$data['halaman'] = array('spb/proses' =>'Spb', 'selesai'=>'Selesai');
		$data['config'] = (object)$this->site_config;
		$data['spb'] = $this->m_spb->getAll(0);
		$this->parser->parse($this->halaman.'/selesai', $data);
	}

	function save(){
		$this->load->model('quo');
		$this->db->trans_begin();
		$nomor = $this->m_spb->getLast()+1;
		$id = $this->m_spb->add($nomor);
		$this->quo->update_status($this->input->post('id'), 2);

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$this->notif->info('Spb gagal ditambahkan', 'error');
		} else {
			$this->db->trans_commit();
			$this->notif->info('Spb berhasil ditambahkan');
		}

		redirect('spb/proses');
	}

	function simpan(){
		echo json_encode($_POST);
	}

	function edit($id){
		$this->load->model('cust');
		$data['halaman'] = array('spb/proses' => 'Spb', 'spb/add'=>'Edit Spb');
		$data['config'] = (object)$this->site_config;
		$data['cust'] = $this->cust->getAll();
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['spb'] = $this->m_spb->getById($id);
		$data['items'] = $this->m_spb->getItemsById($id);
		$this->parser->parse($this->halaman.'/edit', $data);
	}

	function update(){
		$lama = explode(',', $this->input->post('isi'));
		unset($lama[array_search('', $lama)]);
		$this->db->trans_begin();
		$this->m_spb->update();
		$total = 0;
		foreach($this->input->post('desc') as $k => $v){
			if($k>0){
				$data_lama[] = array(
					'items_id' => $k,
					'items_desc' => $v,
					'items_qty' => $this->input->post('qty')[$k],
					'items_satuan' => $this->input->post('satuan')[$k],
					'items_price' => $this->input->post('price')[$k]
				);
				unset($lama[array_search($k, $lama)]);
			} else {
				$data_baru[] = array(
					'items_quo' => $this->input->post('id'),
					'items_desc' => $v,
					'items_qty' => $this->input->post('qty')[$k],
					'items_satuan' => $this->input->post('satuan')[$k],
					'items_price' => $this->input->post('price')[$k]
				);
			}
			$total += ($this->input->post('qty')[$k]*$this->input->post('price')[$k]);
		}

		// check if total is not same
		if($total!=str_replace(',','',$this->input->post('total_sebelum'))){
			$this->db->trans_rollback();
			$this->notif->info('Spb gagal diupdate total='.$total.'-'.$this->input->post('total_sebelum'), 'error');
			redirect('spb');
			exit();
		}

		$this->m_spb->update_batch_items($data_lama);

		if(isset($data_baru)){
			$this->m_spb->add_batch_items($data_baru);
		}

		if(count($lama)>0){
			$this->m_spb->delete_batch_items($lama);
		}

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$this->notif->info('Spb gagal diupdate', 'error');
		} else {
			$this->db->trans_commit();
			$this->notif->info('Spb berhasil diupdate');
		}

		redirect('spb');
	}

	function delete($id){
		if($this->m_spb->delete($id))
			$this->notif->info('Spb berhasil dihapus');
		else
			$this->notif->info('Spb gagal dihapus', 'error');
		redirect('spb');
	}

	function download($id){
		$quo = $this->m_spb->getById($id);
		$item = $this->m_spb->getItemsById($id);
		$this->load->library('excel', array('spb'));
		$satuan = $this->satuan->stn();

		//render nomor
		$this->excel->xls->getActiveSheet()->setCellValue('A6', 'No: '.$quo->spb_nomor);

		//render to
		$this->excel->xls->getActiveSheet()->setCellValue('H8', $quo->customer_nama);
		$this->excel->xls->getActiveSheet()->setCellValue('H9', $quo->customer_site);

		//render date
		$this->excel->xls->getActiveSheet()->setCellValue('L10', date("d M Y", strtotime($quo->spb_tanggal)));

		// RENDER ITEM
		$baseRow = 14;
		$no=0;
		$total=0;
		foreach($item as $i) {
				$row = $baseRow + $no;
				if($no>13){
					$this->excel->xls->getActiveSheet()->insertNewRowBefore($row,1);
					$this->excel->xls->getActiveSheet()->mergeCells('A'.$row.':D'.$row);
					$this->excel->xls->getActiveSheet()->mergeCells('K'.$row.':L'.$row);
				}

				$this->excel->xls->getActiveSheet()->setCellValue('A'.$row, $no+1)
																			->setCellValue('E'.$row, $i->items_desc)
																			->setCellValue('I'.$row, $i->items_qty)
																			->setCellValue('J'.$row, $satuan[$i->items_satuan])
																			->setCellValue('K'.$row, $i->items_price)
																			->setCellValue('M'.$row, $i->items_price*$i->items_qty);
				$total+=$i->items_price*$i->items_qty;
				$no++;
		}

		if($no>13){
			//render pajak
			$this->excel->xls->getActiveSheet()->setCellValue('M'.($row+3), "=".'M'.($row+2)."*".$quo->spb_pajak."/100");
			//render discount
			$this->excel->xls->getActiveSheet()->setCellValue('M'.($row+4), $quo->spb_discount);
			// render grand total
			$this->excel->xls->getActiveSheet()->setCellValue('M'.($row+5), '=M'.($row+2).'+M'.($row+3).'-'.($row+4));
		} else {
			$this->excel->xls->getActiveSheet()->setCellValue('M30', "=".'M29*'.$quo->spb_pajak.'/100');
			$this->excel->xls->getActiveSheet()->setCellValue('M31', $quo->spb_discount);
			$this->excel->xls->getActiveSheet()->setCellValue('M32', '=M29+M30-M31');
		}

		$name = 'spb.xlsx';

		$objWriter = PHPExcel_IOFactory::createWriter($this->excel->xls, 'Excel2007');
		$objWriter->save('hasil/'.$name, __FILE__);

		$this->load->helper('download');
		force_download('hasil/'.$name, NULL);
	}

}
