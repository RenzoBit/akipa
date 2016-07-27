<?php
/**
 * Created by PhpStorm.
 * User: EdsonAndres
 * Date: 18/12/13
 * Time: 0:01
 */

?>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Seguimiento de Ubicación</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <link rel="stylesheet" href="http://jqueryui.com/jquery-wp-content/themes/jqueryui.com/style.css">
    <script type="text/javascript" src="<?php echo base_url(); ?>assets/js/ubicacion.js" ></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyB9VhnBO5wdOzU2o2GX2YrLdnoInaWFP1E&sensor=false"></script>  
    <link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/ubicacion.css">
</head>
<body>
    <div id="accordion" style="">
        <h3>DASHBOARD</h3>
        <div>
            <p>Lets take a trip to sunset bolevard in the city of starts. </p>
        </div>
        <h3>ESTADO DRONE</h3>
        <div>
            <p>Lets take a trip to sunset bolevard in the city of starts. we get it busy in the city. The city of blinfing lights and <a href="http://google.com" target="_blank">starred eyes</a>. The city of Angels.</p>
        </div>
        <h3>ELEMENTO 3</h3>
        <div>
            <p>Texto del Acordion</p>
        </div>
    </div>
    <div class="contenedor">
        <h1>Seguimiento de Ubicación</h1>
        <!--
        <label for="cboClientes">Cliente: </label><select name="cboClientes" id="cboClientes">
            <option value="-1">Seleccionar...</option>
            <?php 
                foreach ($clientes as $cliente) {
                    echo "<option value=\"-1\">" . $cliente['idCliente'] . "</option>\n";
                }
             ?>
        </select>
        
        <button onclick="CargarUbicacionMarcadorClienteActual()">Colocar Marcador de Cliente</button>
        <h2>Última ubicación general enviada:</h2>
        <p>
            Logitud: <span id="logitud">00.000</span> | Latitud: <span id="latitud">00.000</span>
        </p>    
        <button onclick="CargarUbicacionMarcador();">Colocar Marcador de última posición general</button>    
        -->
    </div>

    
    <div id="map_canvas" style="height:100%"></div>
</body>
</html>