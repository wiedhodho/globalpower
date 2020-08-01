<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class M_spb extends CI_Model {
  private $table='spb';
  private $primary_key;
  private $prefix;

  function __construct(){
    parent::__construct();
    $this->prefix = $this->table.'_';
    $this->primary_key = $this->prefix.'id';
  }

  function getAll($status=''){
    if($status!=='')
      $this->db->where($this->prefix.'ref'!='');
    $this->db->join('customer', 'spb_customer=customer_id');
    $this->db->join('quotation', 'quotation_id=spb_quo');
    $this->db->order_by($this->prefix.'lastupdate', 'DESC');
    $query = $this->db->get($this->table);
    return $query->result();
  }

  function getById($id){
    $this->db->join('customer', 'quotation_customer=customer_id', 'LEFT');
    $this->db->where($this->primary_key, $id);
    $query = $this->db->get($this->table);
    return $query->row();
  }

  function getLast(){
    $this->db->select('MAX(spb_nomor) as nomor');
    $this->db->where($this->prefix.'tahun', date('Y'));
    $query = $this->db->get($this->table);
    if($query->row()->nomor!=NULL)
      return $query->row()->nomor;
    else
      return 0;
  }

  function add($nomor){
    $tanggal = explode('/', $this->input->post('tanggal'));
    $data = array(
      $this->prefix.'nomor' => $nomor,
      $this->prefix.'customer' => $this->input->post('customer'),
      $this->prefix.'quo' => $this->input->post('id'),
      $this->prefix.'tanggal' => $tanggal[2].'-'.$tanggal[1].'-'.$tanggal[0],
      $this->prefix.'pengirim' => $this->input->post('pengirim'),
      $this->prefix.'user' => $this->session->username,
      $this->prefix.'tahun' => date('Y')
    );
    $query = $this->db->insert($this->table, $data);
    if($query)
      return $this->db->insert_id();
    else
      return FALSE;
  }

  function update(){
    $tanggal = explode('/', $this->input->post('tanggal'));
    $this->input->post('cash') ? $cash = 0 : $cash = 1;
    $data = array(
      $this->prefix.'cash' => $cash,
      $this->prefix.'jenis' => $this->input->post('jenis'),
      $this->prefix.'customer' => $this->input->post('customer'),
      $this->prefix.'nama' => $this->input->post('nama'),
      $this->prefix.'telp' => $this->input->post('telp'),
      $this->prefix.'tanggal' => $tanggal[2].'-'.$tanggal[1].'-'.$tanggal[0],
      $this->prefix.'total' => str_replace(',','',$this->input->post('total_sebelum')),
      $this->prefix.'pajak' => $this->input->post('pajak'),
      $this->prefix.'discount' => $this->input->post('discount'),
      $this->prefix.'user' => $this->session->username
    );

    $this->db->where($this->primary_key, $this->input->post('id'));
    $query = $this->db->update($this->table, $data);
    if($query)
      return $this->db->affected_rows();
    else
      return FALSE;
  }

  function delete($id){
    $this->db->where($this->primary_key, $id);
    $query = $this->db->delete($this->table);
    if($query)
      return $this->db->affected_rows();
    else
      return FALSE;
  }
}
