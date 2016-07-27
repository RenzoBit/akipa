<?php 
//Validar las variables necesarias
if (!isset($lista_categorias) or $lista_categorias === false){
	$lista_categorias = array();
}
$cbocategorias[''] = 'Seleccionar una categoría...';
foreach ($lista_categorias as $categoria) {
	$cbocategorias[$categoria['idcategoria']] = $categoria['nombre'];
}

 ?>
<h1>Esta es la lista de platos disponibles</h1>


<div class="row">
    <div class="col-xs-12">
        <div class="box">
            <div class="box-header">
                <?php 
				//Formulario para filtro de categoría
					echo '<div class="row">';
						echo '<div class="col-xs-3">';
							echo form_open('plato', array('method'=>'get','role'=>'form'));
							echo '<div class="form-group">';
							echo form_label('Categoría: ', 'categoria-plato');
							echo form_dropdown('categoria_plato', $cbocategorias, $categoria_seleccionada, 'id="categoria-plato" class="form-control" onchange="this.form.submit();"');
                    		echo '</div>';
							echo form_close();
	                    echo '</div>';
						/*echo '<div class="col-xs-3">';
							echo form_input(array('name'=>'nombre_plato', 'value'=>$nombre_plato_buscado, 'id'=>'txt_nombre_plato', 'placeholder'=>'Nombre plato...', 'class'=>'form-control'));
	                    echo '</div>';
						echo '<div class="col-xs-3">';
							echo form_button(array('type'=>'submit', 'content'=>'Buscar', 'class'=>'form-control'));                                            
	                    echo '</div>';
	                    */
                    echo '</div>';
				 ?>
            </div><!-- /.box-header -->
            <div class="box-body  table-responsive">
				<table id="lista-platos" class="jquery-tabla table dataTable table-bordered display" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>Opciones</th>
							<th>Categoría</th>
							<th>Nombre</th>
							<th>Precio</th>
							<th>Relevancia</th>
							<th>Delivery</th>
							<th>Foto</th>
						</tr>
					</thead>
					<tbody>
						<?php foreach ($lista_platos as $plato) {
							$plato['delivery'] = ($plato['delivery'] == 1) ? 'Sí' : 'No';
							$imagen = ($plato['imagen'] == 0) ? '<span> - </span>' : '<img class="imagen-plato" src="'. base_url() .'assets/images/platos/'. $plato['idplato'] .'.jpg" alt="imagen plato">';
							echo '
								<tr>
									<td>
									<div class="btn-group">
									<a class="btn btn-default" href="' . site_url('plato/editar/' . $plato['idplato']) . '"><i class="fa fa-edit"></i></a>
									<a class="btn btn-default" href="' . site_url('plato/eliminar/' . $plato['idplato']) . '" onclick="return confirm(\'Está seguro que desea eliminar el plato\');"><i class="fa fa-trash-o"></i></a>
									</div>
									</td>
									<td>'. $plato['categoria'] .'</td>
									<td>'. $plato['nombre'] .'</td>
									<td>'. $plato['precio'] .'</td>
									<td>'. $plato['relevancia'] .'</td>
									<td>'. $plato['delivery'] .'</td>
									<td>'. $imagen. '</td>
								</tr>
							
							';
						} ?>
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
