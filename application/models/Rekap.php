<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Rekap extends CI_Model {
  private $table = 'rekapinv';
  private $primary_key;
  private $prefix;

  function __construct() {
    parent::__construct();
    $this->prefix = 'rekap_';
    $this->primary_key = $this->prefix . 'id';
  }

  function getAll() {
    $this->db->join('customer', 'rekap_customer=customer_id');
    $this->db->order_by($this->prefix . 'tanggal', 'DESC');
    $query = $this->db->get($this->table);
    return $query->result();
  }

  function getById($id) {
    $this->db->join('customer', 'rekap_customer=customer_id');
    $this->db->where($this->primary_key, $id);
    $query = $this->db->get($this->table);
    return $query->row();
  }

  function add($cust, $inv, $total) {
    $data = array(
      $this->prefix . 'customer' => $cust,
      $this->prefix . 'invoice' => $inv,
      $this->prefix . 'total' => $total,
      $this->prefix . 'user' => $this->session->username
    );
    $query = $this->db->insert($this->table, $data);
    if ($query)
      return $this->db->insert_id();
    else
      return FALSE;
  }

  function update() {
    $data = array(
      $this->prefix . 'customer' => $this->input->post('customer'),
      $this->prefix . 'invoice' => $this->input->post('invoice'),
      $this->prefix . 'total' => $this->input->post('total'),
      $this->prefix . 'user' => $this->session->username
    );

    $this->db->where($this->primary_key, $this->input->post('id'));
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
