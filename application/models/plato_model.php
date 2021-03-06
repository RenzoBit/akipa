<?php
class plato_Model extends CI_Model {
	function getPlatoPorId($idPlato) {
		$idPlato = $this->db->escape ( $idPlato );
		$sql = "SELECT A.idplato, A.nombre, A.descripcion, A.precio, A.idcategoria, A.delivery, A.relevancia, A.imagen, B.nombre AS categoria FROM plato A, categoria B WHERE A.idplato = $idPlato AND A.estado = 1 AND B.idcategoria = A.idcategoria";
		$query = $this->db->query ( $sql );
		return $query->result_array ();
	}
	function getPlatos($nombre_plato = null, $idcategoria = null) {
		$filtro_nombre = isset ( $nombre_plato ) && $nombre_plato ? "A.nombre like '%" . $this->db->escape_like_str ( $nombre_plato ) . "%'" : "1=1";
		$filtro_categoria = isset ( $idcategoria ) && $idcategoria ? "A.idcategoria = " . $this->db->escape ( $idcategoria ) : "1=1";
		$sql = "SELECT A.idplato, A.nombre, A.precio, IFNULL(ROUND(AVG(B.calificacion)), 0) AS calificacion, A.idcategoria, A.delivery, C.nombre as categoria, A.relevancia, A.imagen FROM (plato A LEFT OUTER JOIN pedidodetalle B ON B.idplato = A.idplato LEFT JOIN categoria as C ON A.idcategoria = C.idcategoria) WHERE $filtro_nombre AND $filtro_categoria AND A.estado = 1 GROUP BY A.idplato ORDER BY A.relevancia DESC";
		$query = $this->db->query ( $sql );
		return $query->result_array ();
	}
	function getListaSugerencias($idCliente) {
		$idCliente = $this->db->escape ( $idCliente );
		$sql = "SELECT A.idplato, A.nombre, A.precio, (A.relevancia + IFNULL(COUNT(B.idinteres), 0)) AS relevancia, (SELECT IFNULL(ROUND(AVG(C.calificacion)), 0) FROM pedidodetalle C WHERE C.idplato = A.idplato) AS calificacion, D.nombre AS categoria FROM (plato A LEFT OUTER JOIN interes B ON B.idcliente = $idCliente AND B.idplato = A.idplato AND DATEDIFF(NOW(), B.fecha) BETWEEN 0 AND 120), categoria D WHERE A.delivery AND A.estado = 1 AND D.idcategoria = A.idcategoria GROUP BY A.idplato ORDER BY (A.relevancia + IFNULL(COUNT(B.idinteres), 0)) DESC LIMIT 20";
		$query = $this->db->query ( $sql );
		return $query->result_array ();
	}
	function getPlatosPorCategoria($idCategoria) {
		$idCategoria = $this->db->escape ( $idCategoria );
		$sql = "SELECT A.idplato, A.nombre, A.precio, IFNULL(ROUND(AVG(B.calificacion)), 0) AS calificacion, A.relevancia, A.imagen, D.nombre AS categoria FROM (plato A LEFT OUTER JOIN pedidodetalle B ON B.idplato = A.idplato), categoria D WHERE A.idcategoria = $idCategoria AND A.delivery AND A.estado = 1 AND D.idcategoria = A.idcategoria GROUP BY A.idplato ORDER BY A.relevancia DESC";
		$query = $this->db->query ( $sql );
		return $query->result_array ();
	}
	function getPlatosPorNombre($texto_nombre) {
		$sql = "SELECT A.idplato, A.nombre, A.precio, IFNULL(ROUND(AVG(B.calificacion)), 0) AS calificacion, D.nombre AS categoria FROM (plato A LEFT OUTER JOIN pedidodetalle B ON B.idplato = A.idplato), categoria D WHERE A.nombre LIKE '%" . $this->db->escape_like_str ( $texto_nombre ) . "%' AND A.delivery AND A.estado = 1 AND D.idcategoria = A.idcategoria GROUP BY A.idplato ORDER BY A.relevancia DESC";
		$query = $this->db->query ( $sql );
		return $query->result_array ();
	}
	function updatePlato($idplato, $idcategoria, $nombre_plato, $precio_plato, $relevancia, $delivery, $imagen = null) {
		$data = array (
				'idcategoria' => $idcategoria,
				'nombre' => $nombre_plato,
				'precio' => $precio_plato,
				'relevancia' => $relevancia,
				'delivery' => $delivery 
		);
		if ($imagen !== null)
			$data ['imagen'] = $imagen;
		$this->db->where ( 'idplato', $idplato );
		$respuesta = $this->db->update ( 'plato', $data );
		return $respuesta;
	}
	function deletePlato($idplato) {
		$data = array (
				'estado' => '0' 
		);
		$this->db->where ( 'idplato', $idplato );
		$respuesta = $this->db->update ( 'plato', $data );
		return $respuesta;
	}
}