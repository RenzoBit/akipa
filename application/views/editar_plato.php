<?php 
/*
echo form_open('plato/guardar');

echo form_hidden('idplato', $plato['idplato']);

echo form_label('Categoría: ','cbocategoria');
echo form_dropdown('categoria_plato', $cbocategorias, $plato['idcategoria'], 'id="cbocategoria" class="form-control"');

echo form_label('Nombre: ', 'nombre_plato');
echo form_input(array('name'=>'nombre_plato', 'value'=>$plato['nombre'], 'id'=>'nombre_plato', 'placeholder'=>'Nombre plato...'));

echo form_label('Precio: ', 'precio_plato');
echo form_input(array('name'=>'precio_plato', 'value'=>$plato['precio'], 'id'=>'precio_plato', 'placeholder'=>'Precio plato...'));

echo form_label('Relevancia: ', 'relevancia');
echo form_input(array('name'=>'relevancia', 'value'=>$plato['relevancia'], 'id'=>'relevancia', 'placeholder'=>'Relevancia...'));

echo form_label('Delivery ', 'delivery');
echo form_checkbox(array('name'=>'delivery','value'=>'1', 'checked' => $plato['delivery'] === 1)) ;

echo img('img/plato.jpg');
echo form_upload(array('name'=>'imagen_plato', 'id'=>'imagen_plato'));

echo form_submit('enviar', 'Guardar');
*/
?>

<div class="box box-primary editar-plato">
    <div class="box-header">
        <h3 class="box-title">Editar Plato</h3>
    </div><!-- /.box-header -->
    <!-- form start -->
    <?php echo form_open_multipart('plato/guardar');
		  echo form_hidden('idplato', $plato['idplato']); 
		  ?>
        <div class="box-body">
            
            <div class="row">
            	<div class="col-sm-7">
	            	<div class="form-group">
	            		<?php 
	        			echo form_label('Categoría: ','cbocategoria');
						echo form_dropdown('categoria_plato', $cbocategorias, $plato['idcategoria'], 'id="cbocategoria" class="form-control"');
	            		 ?>
	            	</div>
					<div class="form-group">
	    				<?php 			
						echo form_label('Nombre: ', 'nombre_plato');
						echo form_input(array('name'=>'nombre_plato', 'value'=>$plato['nombre'], 'id'=>'nombre_plato','class'=>'form-control', 'placeholder'=>'Nombre plato...'));
						?>
					</div>
					<div class="form-group">
	    				<?php 
						echo form_label('Precio: ', 'precio_plato');
						echo form_input(array('name'=>'precio_plato', 'value'=>$plato['precio'], 'id'=>'precio_plato','class'=>'form-control', 'placeholder'=>'Precio plato...'));
						?>
					</div>
					<div class="form-group">
	    				<?php 
						echo form_label('Relevancia: ', 'relevancia');
						echo form_input(array('name'=>'relevancia', 'value'=>$plato['relevancia'], 'id'=>'relevancia','class'=>'form-control', 'placeholder'=>'Relevancia...'));
						?>
					</div>
					<div class="form-group">
	    				<?php 
	    				$checked = ($plato['delivery'] == 1) ? true : false;
						echo form_checkbox(array('name'=>'delivery','value'=>'1', 'checked' => $checked,'class'=>'form-control')) ;
						echo form_label('Delivery ', 'delivery');
						?>
					</div>
				</div>				
				<div class="col-sm-5 text-center">
					<?php 
					echo form_label('Imagen Plato: ', 'imagen_plato');
					echo ($plato['imagen'] == 0) ? 'Este plato no tiene aún una imagen.' :  '<img class="imagen-plato margin" src="' . base_url('assets/images/platos/'. $plato['idplato'] . '.jpg') . '" alt="">';
					echo form_upload(array('name'=>'imagen_plato', 'id'=>'imagen_plato', 'style'=>'margin:auto;'));
					?>
				</div>
            </div>
                      
        </div><!-- /.box-body -->

        <div class="box-footer">
            <button type="submit" class="btn btn-primary">Submit</button>
        	<a href="<?php echo site_url('plato'); ?>" class="btn btn-default">Cancelar</a>
        </div>
    <?php echo form_close(); ?>
</div>