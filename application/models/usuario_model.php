<?php
class usuario_Model extends CI_Model {

	function validarUsuario($username, $password) {
		$result = mysql_query("SELECT A.idusuario FROM usuario A WHERE A.username = '$username' AND A.password = MD5('$password')");
		$data = mysql_fetch_assoc($result);
		return $data['idusuario'];
	}
	
	function validarUsuarioxUsername($username) {
		$result = mysql_query("SELECT COUNT(*) AS total FROM usuario A WHERE A.username = '$username'");
		$data = mysql_fetch_assoc($result);
		return $data['total'];
	}
	
	function obtenerUsuario($idusuario) {
		$sql = "SELECT A.idusuario, A.idrol, A.username, B.idcliente, B.nombre, B.apellido FROM usuario A, cliente B WHERE A.idusuario = $idusuario AND B.idusuario = A.idusuario";
		$query = $this->db->query($sql);
		return $query->result_object();
	}
	
	function registrarUsuario($idrol, $username, $password){
		$sql = "INSERT INTO usuario(idrol, username, password) VALUES ($idrol, '$username', MD5('$password'));";
		$query = $this->db->query($sql);
		return $this->db->insert_id();
	}

}