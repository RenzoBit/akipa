<?php
class cliente_Model extends CI_Model {

	function registrarCliente($idusuario, $nombre, $apellido, $correo, $telefono, $facebook, $sexo){
		$sql = "INSERT INTO cliente(idusuario, nombre, apellido, correo, telefono, facebook, sexo) VALUES ($idusuario, '$nombre', '$apellido', '$correo', '$telefono', '$facebook', '$sexo');";
		$query = $this->db->query($sql);
		return $this->db->insert_id();
	}

}