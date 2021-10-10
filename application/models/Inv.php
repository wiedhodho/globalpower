<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Inv extends CI_Model {
  private $table = 'invoice';
  private $primary_key;
  private $prefix;

  function __construct() {
    parent::__construct();
    $this->prefix = 'inv_';
    $this->primary_key = $this->prefix . 'id';
  }

  function getAll($status = 0, $cust = '', $operator = '') {
    if ($cust !== '') $this->db->where($this->prefix . 'customer', $cust);
    $this->db->where($this->prefix . 'status' . $operator, $status);
    $this->db->join('customer', 'inv_customer=customer_id');
    $this->db->join('quotation', 'quotation_id=inv_quo');
    $this->db->order_by($this->prefix . 'lastupdate', 'DESC');
    $query = $this->db->get($this->table);
    // echo $this->db->last_query();
    return $query->result();
  }

  function getAllBelum() {
    $this->db->where($this->prefix . 'status', 0);
    $this->db->select('customer_id, customer_nama, customer_site, SUM(inv_total + (inv_total*inv_pajak/100) - inv_discount) as total, count(inv_id) as banyak');
    $this->db->join('customer', 'inv_customer=customer_id');
    $this->db->order_by($this->prefix . 'lastupdate', 'DESC');
    $this->db->group_by('customer_id');
    $query = $this->db->get($this->table);
    // echo $this->db->last_query();
    return $query->result();
  }

  function getWhereIn($inv_id) {
    $this->db->where_in($this->primary_key, $inv_id);
    $this->db->join('quotation', 'inv_quo=quotation_id');
    $this->db->join('customer', 'inv_customer=customer_id');
    $query = $this->db->get($this->table);
    return $query->result();
  }

  function getTotal($inv_id) {
    $this->db->select('inv_customer, SUM(inv_total) as total');
    $this->db->where_in($this->primary_key, $inv_id);
    $this->db->group_by('inv_customer');
    $query = $this->db->get($this->table);
    // echo $this->db->last_query();
    return $query->row();
  }

  function getById($id) {
    $this->db->join('customer', 'inv_customer=customer_id');
    $this->db->join('quotation', 'quotation_id=inv_quo');
    $this->db->where($this->primary_key, $id);
    $query = $this->db->get($this->table);
    return $query->row();
  }

  function getByQuoId($id) {
    $this->db->join('customer', 'inv_customer=customer_id');
    $this->db->join('quotation', 'quotation_id=inv_quo');
    $this->db->where('inv_quo', $id);
    $query = $this->db->get($this->table);
    return $query->row();
  }

  function getLast() {
    $this->db->select('MAX(inv_nomor) as nomor');
    $this->db->where($this->prefix . 'tahun', date('Y'));
    $query = $this->db->get($this->table);
    if ($query->row()->nomor != NULL)
      return $query->row()->nomor;
    else
      return 0;
  }

  function add($nomor) {
    $tanggal = explode('/', $this->input->post('tanggal'));
    $data = array(
      $this->prefix . 'nomor' => $nomor,
      $this->prefix . 'customer' => $this->input->post('customer'),
      $this->prefix . 'quo' => $this->input->post('id'),
      $this->prefix . 'tanggal' => $tanggal[2] . '-' . $tanggal[1] . '-' . $tanggal[0],
      $this->prefix . 'total' => str_replace(",", "", $this->input->post('total_sebelum')),
      $this->prefix . 'pajak' => $this->input->post('pajak'),
      $this->prefix . 'discount' => $this->input->post('discount'),
      $this->prefix . 'user' => $this->session->username,
      $this->prefix . 'tahun' => date('Y')
    );
    $query = $this->db->insert($this->table, $data);
    if ($query)
      return $this->db->insert_id();
    else
      return FALSE;
  }

  function update() {
    $tanggal = explode('/', $this->input->post('tanggal'));
    $data = array(
      $this->prefix . 'tanggal' => $tanggal[2] . '-' . $tanggal[1] . '-' . $tanggal[0],
      $this->prefix . 'total' => str_replace(",", "", $this->input->post('total_sebelum')),
      $this->prefix . 'pajak' => $this->input->post('pajak'),
      $this->prefix . 'discount' => $this->input->post('discount'),
      $this->prefix . 'user' => $this->session->username
    );

    $this->db->where($this->primary_key, $this->input->post('id'));
    $query = $this->db->update($this->table, $data);
    if ($query)
      return $this->db->affected_rows();
    else
      return FALSE;
  }

  function update_status($id, $status, $mode = '') {
    $data = array(
      $this->prefix . 'status' => $status
    );

    if (is_array($id)) {
      $this->db->where_in($this->primary_key, $id);
    } else if ($mode == 'quo') {
      $this->db->where('inv_quo', $id);
    } else {
      $this->db->where($this->primary_key, $id);
    }
    $query = $this->db->update($this->table, $data);
    if ($query)
      return $this->db->affected_rows();
    else
      return FALSE;
  }

  function delete($id) {
    $this->db->where($this->primary_key, $id);
    $query = $this->db->delete($this->table);
    if ($query)
      return $this->db->affected_rows();
    else
      return FALSE;
  }
}
