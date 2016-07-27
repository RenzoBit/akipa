<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 17/12/13
 * Time: 23:12
 */

class campana_Model extends CI_Model{

    function getCampanas(){
        $q = $this->db->get('promocion');

        return $q->result_array();
    }

    function getCampanaPorId($idCampana){
        $q = $this->db->get_where('campana',array('idcampana'=>$idCampana));
        $resultado = $q->result_array();
        if (sizeof($resultado) > 0){
            return $resultado[0];
        }else{
            return false;
        }
    }

}