<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 17/12/13
 * Time: 23:12
 */

class comentario_Model extends CI_Model{
    
    function getComentariosPorPlato($idPlato){
        $sql = "SELECT A.comentario, A.calificacion, C.facebook, SUBSTR(C.nombre, 1, INSTR(C.nombre,' ') - 1) AS nombre FROM pedidodetalle A, pedido B, cliente C WHERE A.idplato = $idPlato AND (A.comentario <> '' OR A.calificacion <> 0) AND B.idpedido = A.idpedido AND C.idcliente = B.idcliente ORDER BY B.fecha DESC LIMIT 10";
        $query = $this->db->query($sql);

        return $query->result_array();
    }

  
    
}