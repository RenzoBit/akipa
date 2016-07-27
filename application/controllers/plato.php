<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class plato extends CI_Controller {

	function __construct()
	{
		parent::__construct();
	}

	function index()
	{
		$this->load->model(array('plato_model', 'categoria_model'));
		$nombre_plato = $this->input->get('nombre_plato');
		$categoria_plato = $this->input->get('categoria_plato');
		//Buscar platos en la base de datos
		$lista_platos = $this->plato_model->getPlatos($nombre_plato, $categoria_plato);
		
		$data_template['data']['lista_platos'] = $lista_platos;
		$data_template['data']['lista_categorias'] = $this->categoria_model->getCategorias();
		$data_template['data']['categoria_seleccionada'] = $categoria_plato;
		$data_template['data']['nombre_plato_buscado'] = $nombre_plato;
		$data_template['titulo_pagina'] ='Lista de Platos Disponibles';
		$data_template['vista'] ='lista_platos';
		$this->load->view('template', $data_template);
	}

	function editar($idplato){
		$this->load->model(array('plato_model', 'categoria_model'));

		$plato = $this->plato_model->getPlatoPorId($idplato);
		$lista_categorias = $this->categoria_model->getCategorias();

		foreach ($lista_categorias as $categoria) {
			$cbocategorias[$categoria['idcategoria']] = $categoria['nombre'];
		}

		$data_template['data']['cbocategorias'] = $cbocategorias;
		$data_template['data']['plato'] = $plato[0];
		$data_template['titulo_pagina'] ='Editar Plato';
		$data_template['vista'] ='editar_plato';
		$this->load->view('template', $data_template);

	}

	function guardar(){
		//Recuperar y validar todas las variables recibidas
		$idplato = $this->input->post('idplato');
		$idcategoria = $this->input->post('categoria_plato');
		$nombre_plato = $this->input->post('nombre_plato');
		$precio_plato = $this->input->post('precio_plato');
		$relevancia = $this->input->post('relevancia');
		$delivery = $this->input->post('delivery');

		//TODO Validar que el plato exista, que la categoria exista y que los otros valores estén en los rangos esperados
		
		//Realizar carga de imagen de plato si se realizó alguna
		$nombre_campo = 'imagen_plato';
		$imagen_plato = null;
		if (isset($_FILES[$nombre_campo]) && $_FILES[$nombre_campo]['size'] !== 0){
			$config['upload_path'] = './assets/images/platos/';
			$config['allowed_types'] = 'jpg';
			$config['overwrite'] = TRUE;
			$config['max_size']	= '1000';
			$config['file_name']	= $idplato . '.jpg';
			$this->load->library('upload', $config);

			if (!$this->upload->do_upload($nombre_campo)){
				$error = array('error' => $this->upload->display_errors());
				var_dump($error);
				var_dump($_FILES);				
			}else{
				//Si se cargó la imange, actualizar información en BD
				$imagen_plato = 1;
			}
			
		}//Continuar solo si no hubo problemas con la carga de la imagen

		$this->load->model('plato_model');
		$respuesta = $this->plato_model->updatePlato($idplato, $idcategoria, $nombre_plato, $precio_plato, $relevancia, $delivery, $imagen_plato);

		if (!$respuesta){
			redirect('plato/editar/' . $idplato);
		}
		$this->index();
	}

	function eliminar($idplato){
		//TODO Validar que el plato exista, que la categoria exista y que los otros valores estén en los rangos esperados
		$this->load->model('plato_model');

		$respuesta = $this->plato_model->deletePlato($idplato);
		
		$this->index();
	}

}

/* End of file welcome.php */
/* Location: ./system/application/controllers/welcome.php */