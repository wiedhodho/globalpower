<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Setting extends CI_Model {

        private $table = 'settings';
        private $primary_key='settings_id';
        private $prefix='settings_';

        function getAll() {
                $query = $this->db->get($this->table);
                return $query->result();
        }

        function getById($id) {
                $this->db->where($this->primary_key, $id);
                $query = $this->db->get($this->table);
                return $query->row();
        }

        function update(){
                $this->db->where($this->primary_key, $this->input->post('id'));
                $data = array(
                        $this->prefix.'value' => $this->input->post('value')
                        );
                $query = $this->db->update($this->table, $data);
                if($query)
                        return $this->db->affected_rows();
                else
                        return FALSE;
        }
}
