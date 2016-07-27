<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 17/12/13
 * Time: 23:12
 */

class categoria_Model extends CI_Model{

    function getCategorias(){
        $sql = "SELECT A.idcategoria, A.nombre FROM categoria A;";
        $query = $this->db->query($sql);

        return $query->result_array();
    }    

    function getCategoriasConPlatos(){
        $sql = "SELECT A.idcategoria, A.nombre FROM categoria A WHERE EXISTS (SELECT 1 FROM plato B WHERE B.idcategoria = A.idcategoria AND B.delivery);";
        $query = $this->db->query($sql);

        return $query->result_array();
    }   

}