<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 18/12/13
 * Time: 0:12
 */

class Ubicacion extends CI_Controller {

    function index(){
    	$this->load->model('Ubicacion_Model');
    	$this->load->helper('url');
		//Recuperar los clientes
    	$clientes = $this->Ubicacion_Model->getClientes();

    	$data['clientes'] = $clientes;
        $this->load->view('seguimiento_ubicacion',$data);

    }

}