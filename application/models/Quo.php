<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Quo extends CI_Model {
  private $table='quotation';
  private $primary_key;
  private $prefix;

  function __construct(){
    parent::__construct();
    $this->prefix = $this->table.'_';
    $this->primary_key = $this->prefix.'id';
  }

  function getAll(){
    $this->db->join('customer', 'quotation_customer=customer_id', 'LEFT');
    $this->db->order_by($this->prefix.'lastupdate', 'DESC');
    $query = $this->db->get($this->table);
    return $query->result();
  }

  function getById($id){
    $this->db->where($this->primary_key, $id);
    $query = $this->db->get($this->table);
    return $query->row();
  }

  function getLast(){
    $this->db->select('MAX(quotation_nomor) as nomor');
    $this->db->where($this->prefix.'tahun', date('Y'));
    $query = $this->db->get($this->table);
    if($query->row()->nomor!=NULL)
      return $query->row()->nomor;
    else
      return 0;
  }

  function add($nomor){
    $tanggal = explode('/', $this->input->post('tanggal'));
    $this->input->post('cash') ? $cash = 1 : $cash = 0;
    $data = array(
      $this->prefix.'cash' => $cash,
      $this->prefix.'jenis' => $this->input->post('jenis'),
      $this->prefix.'nomor' => $nomor,
      $this->prefix.'customer' => $this->input->post('customer'),
      $this->prefix.'nama' => $this->input->post('nama'),
      $this->prefix.'telp' => $this->input->post('telp'),
      $this->prefix.'tanggal' => $tanggal[2].'-'.$tanggal[1].'-'.$tanggal[0],
      $this->prefix.'total' => str_replace(',','',$this->input->post('total_sebelum')),
      $this->prefix.'pajak' => $this->input->post('pajak'),
      $this->prefix.'discount' => $this->input->post('discount'),
      $this->prefix.'user' => $this->session->username,
      $this->prefix.'tahun' => date('Y')
    );
    $query = $this->db->insert($this->table, $data);
    if($query)
      return $this->db->insert_id();
    else
      return FALSE;
  }

  function add_batch_items($data){
    $query = $this->db->insert_batch('items', $data);
    if($query)
      return TRUE;
    else
      return FALSE;
  }

  function update(){
    $data = array(
      $this->prefix.'nama' => $this->input->post('nama'),
      $this->prefix.'alamat' => $this->input->post('alamat'),
      $this->prefix.'kota' => $this->input->post('kota'),
      $this->prefix.'site' => $this->input->post('site'),
      $this->prefix.'telp' => $this->input->post('telp'),
      $this->prefix.'email' => $this->input->post('email')
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
