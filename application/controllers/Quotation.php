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
		$data['quo'] = $this->quo->getAll(0);
		$data['jenis'] = $this->satuan->jenis();
		$data['warna'] = $this->satuan->warna();
		$this->parser->parse($this->halaman.'/index', $data);
	}

	function batal(){
		$data['halaman'] = array('quotation' =>'Quotation');
		$data['config'] = (object)$this->site_config;
		$data['quo'] = $this->quo->getAll(-1);
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
		$total = 0;
		foreach($this->input->post('desc') as $k => $v){
			$data[] = array(
				'items_quo' => $id,
				'items_desc' => $v,
				'items_qty' => $this->input->post('qty')[$k],
				'items_satuan' => $this->input->post('satuan')[$k],
				'items_price' => $this->input->post('price')[$k]
			);
			$total += ($this->input->post('qty')[$k]*$this->input->post('price')[$k]);
		}

		if($total!=str_replace(',','',$this->input->post('total_sebelum'))){
			$this->db->trans_rollback();
			$this->notif->info('Quotation gagal ditambahkan', 'error');
			redirect('quotation');
			exit();
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
		$this->load->model('cust');
		$data['halaman'] = array('quotation' => 'Quotation', 'add'=>'Edit Quotation');
		$data['config'] = (object)$this->site_config;
		$data['cust'] = $this->cust->getAll();
		$data['satuan'] = $this->satuan->stn();
		$data['jenis'] = $this->satuan->jenis();
		$data['quo'] = $this->quo->getById($id);
		$data['items'] = $this->quo->getItemsById($id);
		$this->parser->parse($this->halaman.'/edit', $data);
	}

	function update(){
		$lama = explode(',', $this->input->post('isi'));
		unset($lama[array_search('', $lama)]);
		$this->db->trans_begin();
		$this->quo->update();
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
			$this->notif->info('Quotation gagal diupdate total='.$total.'-'.$this->input->post('total_sebelum'), 'error');
			redirect('quotation');
			exit();
		}

		$this->quo->update_batch_items($data_lama);

		if(isset($data_baru)){
			$this->quo->add_batch_items($data_baru);
		}

		if(count($lama)>0){
			$this->quo->delete_batch_items($lama);
		}

		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			$this->notif->info('Quotation gagal diupdate', 'error');
		} else {
			$this->db->trans_commit();
			$this->notif->info('Quotation berhasil diupdate');
		}

		redirect('quotation');
	}

	function delete($id){
		if($this->quo->delete($id))
			$this->notif->info('Quotation berhasil dihapus');
		else
			$this->notif->info('Quotation gagal dihapus', 'error');
		redirect('quotation');
	}

	function proses($id){
		if($this->quo->update_status($id, 1))
			$this->notif->info('Quotation berhasil diproses');
		else
			$this->notif->info('Quotation gagal diproses', 'error');
		redirect('quotation');
	}

	function batalkan($id){
		if($this->quo->update_status($id, -1))
			$this->notif->info('Quotation berhasil dibatalkan');
		else
			$this->notif->info('Quotation gagal dibatalkan', 'error');
		redirect('quotation');
	}

	function download($id){
		$quo = $this->quo->getById($id);
		$item = $this->quo->getItemsById($id);
		$this->load->library('excel', array('quotation'));
		$satuan = $this->satuan->stn();

		//render nomor
		$this->excel->xls->getActiveSheet()->setCellValue('A6', 'No: '.$quo->quotation_nomor);

		//render to
		$this->excel->xls->getActiveSheet()->setCellValue('H8', $quo->customer_nama);
		$this->excel->xls->getActiveSheet()->setCellValue('H9', $quo->customer_site);

		//render date
		$this->excel->xls->getActiveSheet()->setCellValue('L10', date("d M Y", strtotime($quo->quotation_tanggal)));

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
			$this->excel->xls->getActiveSheet()->setCellValue('M'.($row+3), "=".'M'.($row+2)."*".$quo->quotation_pajak."/100");
			//render discount
			$this->excel->xls->getActiveSheet()->setCellValue('M'.($row+4), $quo->quotation_discount);
			// render grand total
			$this->excel->xls->getActiveSheet()->setCellValue('M'.($row+5), '=M'.($row+2).'+M'.($row+3).'-'.($row+4));
		} else {
			$this->excel->xls->getActiveSheet()->setCellValue('M30', "=".'M29*'.$quo->quotation_pajak.'/100');
			$this->excel->xls->getActiveSheet()->setCellValue('M31', $quo->quotation_discount);
			$this->excel->xls->getActiveSheet()->setCellValue('M32', '=M29+M30-M31');
		}

		$name = 'quotation.xlsx';

		$objWriter = PHPExcel_IOFactory::createWriter($this->excel->xls, 'Excel2007');
		$objWriter->save('hasil/'.$name, __FILE__);

		$this->load->helper('download');
		force_download('hasil/'.$name, NULL);
	}

}
