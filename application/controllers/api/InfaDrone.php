<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 17/12/13
 * Time: 22:58
 */

require APPPATH.'/libraries/REST_Controller.php';

class InfaDrone extends REST_Controller {

    function ubicacion_get(){
        $this->load->model('Ubicacion_Model');
        
        $idCliente = $this->get('idCliente');

        if (isset($idCliente) && $idCliente != ""){
            $ubicacion = $this->Ubicacion_Model->getUltimaUbicacionPorCliente($idCliente);
        }else{
            $ubicacion = $this->Ubicacion_Model->getUltimaUbicacion();
        }
        $this->response($ubicacion, 200);
    }

    function getAllUbicacion_get(){
        $this->load->model('Ubicacion_Model');
                
        $ubicacion = $this->Ubicacion_Model->getAllUltimaUbicacion();
        
        foreach ($ubicacion as &$value) {
            switch ($value['id_cliente']) {
                 case 'edanmegu@gmail.com':
                     $value['imagen'] = 'mark-edson.png';
                     break;
                 case 'tegobijava@gmail.com':
                     $value['imagen'] = 'mark-renzo.png';
                     break;
                 case 'garridolecca.rivera@gmail.com':
                     $value['imagen'] = 'mark-cesar.png';
                     break;
                 default:
                     $value['imagen'] = 'mark-null.png';
                     break;
             } 
            
        }

        $this->response($ubicacion, 200);
    }

    function ubicacion_post(){
        $this->load->model('Ubicacion_Model');

        if ($this->post('idCliente')){
            $id_cliente = $this->post('idCliente');            
        }elseif($this->get('idCliente')){
            $id_cliente = $this->get('idCliente');
        }else{
            $id_cliente = null;
        }
        if ($this->post('idCelular')){
            $id_celular = $this->post('idCelular');
        }elseif($this->get('idCelular')){
            $id_celular = $this->get('idCelular');
        }else{
            $id_celular = null;
        }
        if ($this->post('Latitud')){
            $latitud = $this->post('Latitud');
        }elseif($this->get('Latitud')){
            $latitud = $this->get('Latitud');
        }else{
            $latitud = null;
        }
        if ($this->post('Longitud')){
            $longitud = $this->post('Longitud');
        }elseif($this->get('Longitud')){
            $longitud = $this->get('Longitud');
        }else{
            $longitud = null;
        }

        //$this->response($id_cliente . ' - ' . $id_celular . ' - ' . $latitud . ' - ' . $longitud, 200);

        $resultado = $this->Ubicacion_Model->setUbiacionCliente($id_cliente, $id_celular, $latitud, $longitud);

        if($resultado == 1){
            $this->response($this->Ubicacion_Model->getUltimaUbicacion(), 200);
        }else{
            $this->response('Error al actualizar', 404);
        }


    }

}