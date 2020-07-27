<?php
class User extends CI_Model {

	private $table = 'users';
	private $prefix = 'users_';
	private $primary_key = 'users_id';
	private $encrypt='sha1';

	function getAll(){
		$this->db->where($this->prefix.'deleted', '0');
		$this->db->order_by($this->primary_key, 'DESC');
		$query = $this->db->get($this->table);
		return $query->result();
	}

	function getAllSalah(){
		$this->db->where('log_status', '0');
		$this->db->order_by('log_lastupdate', 'DESC');
		$query = $this->db->get('logger');
		return $query->result();
	}

	function generate_random_string($name_length = 25) {
		$alpha_numeric = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwqyz1234567890~!@#$%^&*()_+';
		return substr(str_shuffle($alpha_numeric), 0, $name_length);
	}

	function getById($id){
		$this->db->where($this->prefix.'deleted', '0');
		$this->db->where($this->primary_key, $id);
		$query = $this->db->get($this->table);
		return $query->row();
	}

	function login(){
		$this->db->where($this->prefix.'name', $this->input->post('username'));
		$this->db->where($this->prefix.'pass='.$this->encrypt.'(concat(\''.$this->input->post('password').'\',users_salt))');
		$query = $this->db->get($this->table);
		// echo $this->db->last_query();

		if($query->num_rows() === 1){
			$this->logger($this->input->post('username'), $this->input->post('password'), $this->input->ip_address(), '1');
			return $query->row();
		} else {
			$this->logger($this->input->post('username'), $this->input->post('password'), $this->input->ip_address(), '0');
			return FALSE;
		}
	}

	protected function logger($username, $password, $ip, $status){
		$data = array(
			'log_user' => $username,
			'log_password' => $password,
			'log_ip' => $ip,
			'log_status' => $status
			);
		$query = $this->db->insert('logger', $data);
		if($query)
    	return $this->db->insert_id();
    else
    	return FALSE;
	}

	function logout($userid){
		$this->db->where($this->primary_key, $userid);
		$data = array(
			$this->prefix.'lastip' => $_SERVER['REMOTE_ADDR'],
			$this->prefix.'lastlogin' => strftime("%Y-%m-%d %H:%M:%S")
    );
    $query = $this->db->update($this->table, $data);
	}

	function add($foto=''){
		$data = array(
			$this->prefix.'name' => $this->input->post('username'),
			$this->prefix.'level' => $this->input->post('level'),
			$this->prefix.'nama' => $this->input->post('nama')
    );
    $salt = $this->generate_random_string();
    if($this->encrypt=='md5')
    	$password = md5($this->input->post('password').$salt);
    else if($this->encrypt=='sha1')
    	$password = sha1($this->input->post('password').$salt);
    $data[$this->prefix.'pass'] = $password;
    $data[$this->prefix.'salt'] = $salt;
    $query = $this->db->insert($this->table, $data);
    if($query)
    	return $this->db->insert_id();
    else
    	return FALSE;
	}

	function update($foto=''){
		$data = array(
			$this->prefix.'name' => $this->input->post('username'),
			$this->prefix.'level' => $this->input->post('level'),
			$this->prefix.'nama' => $this->input->post('nama')
    );
    if($this->input->post('password') != ''){
    	$salt = $this->generate_random_string();
      if($this->encrypt=='md5')
      	$password = md5($this->input->post('password').$salt);
      else if($this->encrypt=='sha1')
      	$password = sha1($this->input->post('password').$salt);
      $data[$this->prefix.'pass'] = $password;
    	$data[$this->prefix.'salt'] = $salt;
    }

		if($foto!='')
			$data[$this->prefix.'foto'] = $foto;

    $this->db->where($this->primary_key, $this->input->post('id'));
    $query = $this->db->update($this->table, $data);
    if($query)
    	return $this->db->affected_rows();
    else
    	return FALSE;
	}

	function update_profil($foto=''){
		$data = array(
			$this->prefix.'name' => $this->input->post('username'),
			$this->prefix.'email' => $this->input->post('email'),
			$this->prefix.'nip' => $this->input->post('nip'),
			$this->prefix.'nohp' => $this->input->post('nohp'),
			$this->prefix.'nama' => $this->input->post('nama')
    );
    if($this->input->post('password') != ''){
    	$salt = $this->generate_random_string();
      if($this->encrypt=='md5')
      	$password = md5($this->input->post('password').$salt);
      else if($this->encrypt=='sha1')
      	$password = sha1($this->input->post('password').$salt);
      $data[$this->prefix.'pass'] = $password;
    	$data[$this->prefix.'salt'] = $salt;
    }

		if($foto!='')
			$data[$this->prefix.'foto'] = $foto;

    $this->db->where($this->primary_key, $this->session->userid);
    $query = $this->db->update($this->table, $data);
    if($query)
    	return $this->db->affected_rows();
    else
    	return FALSE;
	}

	function delete($id){
		$this->db->where($this->primary_key, $id);
		$data = array(
			$this->prefix.'deleted' => '1'
		);
		$query = $this->db->update($this->table, $data);
		if($query)
        	return $this->db->affected_rows();
        else
        	return FALSE;
	}

	function countAll() {
		$this->db->where($this->prefix.'deleted', '0');
		$this->db->from($this->table);
		return $this->db->count_all_results();
	}
}
