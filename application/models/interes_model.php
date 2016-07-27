<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 17/12/13
 * Time: 23:12
 */

class interes_Model extends CI_Model{
    
    function createInteres($idCliente, $idPlato){
        $sql = "INSERT INTO interes(idcliente, idplato) VALUES ($idCliente, $idPlato);";
        $query = $this->db->query($sql);

        return $this->db->insert_id();
    }

}