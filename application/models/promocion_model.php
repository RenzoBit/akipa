<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 17/12/13
 * Time: 23:12
 */

class promocion_Model extends CI_Model{

    function getPromociones(){
        $q = $this->db->get('promocion');

        return $q->result_array();
    }

    function agregarPromocion($nombre_promocion, $codigo_promocion, $fecha_inicio, $fecha_fin){
        $array = array();
        $this->db->insert();
    }

}