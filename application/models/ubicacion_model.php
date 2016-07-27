<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 17/12/13
 * Time: 23:12
 */

class Ubicacion_Model extends CI_Model{

    function getClientes(){
        $sql = "SELECT distinct(id_cliente) as idCliente FROM ubicacion";
        $query = $this->db->query($sql);

        return $query->result_array();
    }

    function getUltimaUbicacion(){
        $sql = "SELECT * FROM ubicacion ORDER BY id_ubicacion desc LIMIT 1";
        $query = $this->db->query($sql);

        return $query->result_array();
    }

    function getAllUltimaUbicacion(){
        $sql = "SELECT * FROM ubicacion WHERE id_ubicacion
                IN (
                    SELECT MAX( id_ubicacion ) FROM  `ubicacion` 
                    GROUP BY id_cliente
                    ORDER BY id_ubicacion DESC
                )";
        $query = $this->db->query($sql);

        return $query->result_array();
    }

    function getUltimaUbicacionPorCliente($idCliente){
        $sql = "SELECT * FROM ubicacion where id_cliente = '$idCliente' ORDER BY id_ubicacion desc LIMIT 1";
        $query = $this->db->query($sql);

        return $query->result_array();
    }

    function setUbiacionCliente($id_cliente, $id_celular, $latitud, $longitud){
        $data = array(
            'id_cliente'=>$id_cliente,
            'id_celular'=>$id_celular,
            'lat'=>$latitud,
            'lon'=>$longitud
        );

        $this->db->insert('ubicacion',$data);

        return $this->db->affected_rows();
    }

}