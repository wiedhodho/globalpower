<?php

defined('BASEPATH') or exit('No direct script access allowed');

class Quo extends CI_Model {
  private $table = 'quotation';
  private $primary_key;
  private $prefix;

  function __construct() {
    parent::__construct();
    $this->prefix = $this->table . '_';
    $this->primary_key = $this->prefix . 'id';
  }

  function getAll($status = '') {
    if ($status !== '') {
      // $pos = strpos($status, '<') + strpos($status, '>') + strpos($status, '!');
      $pos = strpos($status, '>');
      if ($pos !== false) {
        $this->db->where($this->prefix . 'status' . $status);
        // echo 'biasa'.$pos;
      } else if (strpos($status, '&')) {
        $status = explode('&', $status);
        $this->db->where($this->prefix . 'status', $status[0]);
        $this->db->or_where($this->prefix . 'status', $status[1]);
      } else {
        $this->db->where($this->prefix . 'status', $status);
        // echo 'tidak'.$pos;
      }
    }
    $this->db->join('customer', 'quotation_customer=customer_id', 'LEFT');
    $this->db->order_by($this->prefix . 'lastupdate', 'DESC');
    $query = $this->db->get($this->table);
    // echo $this->db->last_query();
    return $query->result();
  }

  function getById($id) {
    $this->db->join('customer', 'quotation_customer=customer_id', 'LEFT');
    $this->db->where($this->primary_key, $id);
    $query = $this->db->get($this->table);
    return $query->row();
  }

  function getLast() {
    $this->db->select('MAX(quotation_nomor) as nomor');
    $this->db->where($this->prefix . 'tahun', date('Y'));
    $query = $this->db->get($this->table);
    if ($query->row()->nomor != NULL)
      return $query->row()->nomor;
    else
      return 0;
  }

  function add($nomor) {
    $tanggal = explode('/', $this->input->post('tanggal'));
    $this->input->post('cash') ? $cash = 0 : $cash = 1;
    $data = array(
      $this->prefix . 'cash' => $cash,
      $this->prefix . 'jenis' => $this->input->post('jenis'),
      $this->prefix . 'nomor' => $nomor,
      $this->prefix . 'customer' => $this->input->post('customer'),
      $this->prefix . 'nama' => $this->input->post('nama'),
      $this->prefix . 'telp' => $this->input->post('telp'),
      $this->prefix . 'tanggal' => $tanggal[2] . '-' . $tanggal[1] . '-' . $tanggal[0],
      $this->prefix . 'total' => preg_replace('/[0-9]+/', '', $this->input->post('total_sebelum')),
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

  function getItemsById($id) {
    $this->db->join('quotation', 'quotation_id=items_quo');
    $this->db->where('items_quo', $id);
    $query = $this->db->get('items');
    return $query->result();
  }

  function add_batch_items($data) {
    $query = $this->db->insert_batch('items', $data);
    if ($query)
      return TRUE;
    else
      return FALSE;
  }

  function update_batch_items($data) {
    $query = $this->db->update_batch('items', $data, 'items_id');
    if ($query)
      return TRUE;
    else
      return FALSE;
  }

  function delete_batch_items($data) {
    $this->db->where_in('items_id', $data);
    $query = $this->db->delete('items');
    if ($query)
      return TRUE;
    else
      return FALSE;
  }

  function update($total) {
    $tanggal = explode('/', $this->input->post('tanggal'));
    $this->input->post('cash') ? $cash = 0 : $cash = 1;
    $data = array(
      $this->prefix . 'cash' => $cash,
      $this->prefix . 'jenis' => $this->input->post('jenis'),
      $this->prefix . 'customer' => $this->input->post('customer'),
      $this->prefix . 'nama' => $this->input->post('nama'),
      $this->prefix . 'telp' => $this->input->post('telp'),
      $this->prefix . 'tanggal' => $tanggal[2] . '-' . $tanggal[1] . '-' . $tanggal[0],
      $this->prefix . 'total' => $total,
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

  function delete($id) {
    $this->db->where($this->primary_key, $id);
    $query = $this->db->delete($this->table);
    if ($query)
      return $this->db->affected_rows();
    else
      return FALSE;
  }

  function update_status($id, $status) {
    $data = array(
      'history_quo' => $id,
      'history_status' => $status,
      'history_user' => $this->session->username
    );
    $query = $this->db->insert('history', $data);
    if ($query)
      return TRUE;
    else
      return FALSE;
  }

  function getHistory($id) {
    $this->db->join('quotation', 'quotation_id=history_quo');
    $this->db->where('history_quo', $id);
    $query = $this->db->get('history');
    return $query->result();
  }

  function countAll($jenis = '') {
    $this->db->where($this->prefix . 'tahun', date('Y'));
    if ($jenis !== '')
      $this->db->where($this->prefix . 'jenis', $jenis);
    $this->db->select('count(*) as banyak, sum(quotation_total+(quotation_total*quotation_pajak/100)-quotation_discount) as total');
    $query = $this->db->get($this->table);
    return $query->row();
  }

  function countByBulan($tahun) {
    $this->db->where($this->prefix . 'tahun', $tahun);
    $this->db->select('count(*) as banyak, MONTH(quotation_tanggal) as bulan, quotation_jenis');
    $this->db->order_by('bulan');
    $this->db->group_by('bulan, quotation_jenis');
    $query = $this->db->get($this->table);
    return $query->result();
  }
}
