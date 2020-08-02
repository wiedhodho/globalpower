<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Cust extends CI_Model {
  private $table='customer';
  private $primary_key;
  private $prefix;

  function __construct(){
    parent::__construct();
    $this->prefix = $this->table.'_';
    $this->primary_key = $this->prefix.'id';
  }

  function getAll(){
    $this->db->where($this->prefix.'deleted', '0');
    $query = $this->db->get($this->table);
    return $query->result();
  }
  function getById($id){
    $this->db->where($this->primary_key, $id);
    $query = $this->db->get($this->table);
    return $query->row();
  }
  function add(){
    $data = array(
      $this->prefix.'nama' => $this->input->post('nama'),
      $this->prefix.'alamat' => $this->input->post('alamat'),
      $this->prefix.'kota' => $this->input->post('kota'),
      $this->prefix.'site' => $this->input->post('site'),
      $this->prefix.'telp' => $this->input->post('telp'),
      $this->prefix.'email' => $this->input->post('email')
    );
    $query = $this->db->insert($this->table, $data);
    if($query)
      return $this->db->insert_id();
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
    $data = array(
      $this->prefix.'deleted' => '1'
    );
    $this->db->where($this->primary_key, $id);
    $query = $this->db->update($this->table, $data);
    if($query)
      return $this->db->affected_rows();
    else
      return FALSE;
  }

  function countAll(){
    $this->db->where($this->prefix.'deleted', '0');
    $this->db->select('count(*) as banyak');
    $query = $this->db->get($this->table);
    return $query->row()->banyak;
  }
}
