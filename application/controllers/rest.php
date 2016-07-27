<?php

require APPPATH.'/libraries/REST_Controller.php';

class rest extends REST_Controller {
	
	function lista_sugerencias_get() {
		$this->load->model('plato_model');
		$idCliente = $this->get('idcliente');
		if (isset($idCliente) && $idCliente != "")
			$lista_sugerencias = $this->plato_model->getListaSugerencias($idCliente);
		else
			$lista_sugerencias = false;
		//$this->response(json_encode($lista_sugerencias), 200);
		$this->response($lista_sugerencias, 200);
	}
	
	function obtener_plato_get() {
		$this->load->model('plato_model');
		$idPlato = $this->get('idplato');
		$plato = $this->plato_model->getPlatoPorId($idPlato);
		if (!isset($plato[0]))
			$plato = false; 
		else
			$plato = $plato[0];
		//$this->response(json_encode($plato), 200);
		$this->response($plato, 200);
	}
	
	function lista_platos_por_idcategoria_get() {
		$this->load->model('plato_model');
		$idcategoria = $this->get('idcategoria');
		$lista_platos = $this->plato_model->getPlatosPorCategoria($idcategoria);
		if (!$lista_platos)
			$lista_platos = false; 
		//$this->response(json_encode($lista_platos), 200);
		$this->response($lista_platos, 200);
	}
	
	function lista_platos_por_nombre_get() {
		$this->load->model('plato_model');
		$texto_nombre = $this->get('nombre');
		$lista_platos = $this->plato_model->getPlatosPorNombre($texto_nombre);
		if (!$lista_platos)
			$lista_platos = false; 
		//$this->response(json_encode($lista_platos), 200);
		$this->response($lista_platos, 200);
	}
	
	function lista_categorias_con_platos_get() {
		$this->load->model('categoria_model');
		$lista_categorias = $this->categoria_model->getCategoriasConPlatos();
		if (!isset($lista_categorias) || $lista_categorias == "")
			$lista_categorias = false;
		//$this->response(json_encode($lista_categorias), 200);
		$this->response($lista_categorias, 200);
	}		
	
	function lista_comentarios_por_plato_get() {
		$this->load->model('comentario_model');
		$idPlato = $this->get('idplato');
		$lista_comentarios = $this->comentario_model->getComentariosPorPlato($idPlato);
		if (!$lista_comentarios)
			$lista_comentarios = false; 
		//$this->response(json_encode($lista_comentarios), 200);
		$this->response($lista_comentarios, 200);
	}
	
	function crear_interes_post() {
		$this->load->model('interes_model');
		$idCliente = $this->post('idcliente');
		$idPlato = $this->post('idplato');
		$idInteres = $this->interes_model->createInteres($idCliente, $idPlato);
		if (!$idInteres)
			$idInteres = false; 
		//$this->response(json_encode($idInteres), 200);
		$this->response($idInteres, 200);
	}
	
	function validate_user_get() {
		$this->load->model('usuario_model');
		$username = $this->get('username');
		$password = $this->get('password');
		if ($username == '' or $password == '')
			$objeto = 0;
		else {
			$objeto = $this->usuario_model->validarUsuario($username, $password);
			if (!isset($objeto))
				$objeto = 0;
		}
		//$this->response(json_encode($objeto), 200);
		$this->response($objeto, 200);
	}
	
	function get_user_get() {
		$this->load->model('usuario_model');
		$idusuario = $this->get('idusuario');
		$objeto = $this->usuario_model->obtenerUsuario($idusuario);
		if (!isset($objeto))
			$objeto = false;
		//$this->response(json_encode($objeto), 200);
		$this->response($objeto, 200);
	}
	
	function save_user_post() {
		$this->load->model('usuario_model');
		$this->load->model('cliente_model');
		$nombre = $this->post('nombre');
		$apellido = $this->post('apellido');
		$correo = $this->post('correo');
		$telefono = $this->post('telefono');
		$password = $this->post('password');
		$facebook = $this->post('facebook');
		$sexo = $this->post('sexo');
		$objeto = $this->usuario_model->validarUsuarioxUsername($correo);
		if ($objeto == 0) {
			$idusuario = $this->usuario_model->registrarUsuario(1, $correo, $password);
			$idcliente = $this->cliente_model->registrarCliente($idusuario, $nombre, $apellido, $correo, $telefono, $facebook, $sexo);
			$objeto = $idusuario;
		} else
			$objeto = 0;
		//$this->response(json_encode($objeto), 200);
		$this->response($objeto, 200);
	}
		
}

?>