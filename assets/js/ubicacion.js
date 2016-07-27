var array_ubicacion = new Array();
var debug_ubicacion = null;
        $(document).ready(function(){
            //Aplicar Acoordion
            $( "#accordion").accordion({
                heightStyle: "content"
            });
            //
            interval = setInterval(CargarTodoUbicacionMarcador,1000);
              var myLatLng = new google.maps.LatLng(-12.14, -76.99);  
              var mapOptions = {
                zoom: 13,
                center: myLatLng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
              };              
              mapa = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);



        });

        function CargarUbicacion(){
            $.ajax({
                type: "GET",
                url: 'http://enginzone.org/edson/Restful/index.php/api/InfaDrone/ubicacion',
                dataType:"json",
                success: function(data){
                    var obj = data;
                    $('#logitud').text(data[0].lon);
                    $('#latitud').text(data[0].lat);
                },
                error: function (){
                    alert('Error');
                }
            });

        }
        function CargarUbicacionMarcador(){
            $.ajax({
                type: "GET",
                url: 'http://enginzone.org/edson/Restful/index.php/api/InfaDrone/ubicacion',
                dataType:"json",
                success: function(data){
                    var myLatlngPH = new google.maps.LatLng(data[0].lat,data[0].lon);
                    var marker = new google.maps.Marker({
                          position: myLatlngPH,
                          map: mapa,
                          title: 'Hello World!'
                      });
                },
                error: function (){
                    alert('Error');
                }
            });

        }

        function CargarUbicacionMarcadorClienteActual(){
            var idCliente = $('#cboClientes').find('option')[$('#cboClientes')[0].selectedIndex].text;
            $.ajax({
                type: "GET",
                url: 'http://enginzone.org/edson/Restful/index.php/api/InfaDrone/ubicacion?idCliente=' + idCliente,
                dataType:"json",
                success: function(data){
                    var myLatlngPH = new google.maps.LatLng(data[0].lat,data[0].lon);
                    var marker = new google.maps.Marker({
                          position: myLatlngPH,
                          map: mapa,
                          title: idCliente
                      });
                },
                error: function (){
                    alert('Error');
                }
            });

        }

        function CargarTodoUbicacionMarcador(){
            $.ajax({
                type: "GET",
                url: 'http://enginzone.org/edson/Restful/index.php/api/InfaDrone/getAllUbicacion',
                dataType:"json",
                success: function(posicion){
                    var myLatlngPH = null;
                    var marker = null;
                    var imagen = null;
                    var idCliente = null;
                    for (var i = posicion.length - 1; i >= 0; i--) {                        
                        
                        idCliente = posicion[i].id_cliente;
                        imagen = '../assets/images/' + posicion[i].imagen;

                        if (typeof array_ubicacion[idCliente] == 'undefined'){
                            //Crear nuevo marcador
                            myLatlngPH = new google.maps.LatLng(posicion[i].lat, posicion[i].lon);
                            marker = new google.maps.Marker({
                                  position: myLatlngPH,
                                  map: mapa,
                                  title: idCliente,
                                  icon: imagen
                            });

                            posicion[i].marcador = marker;
                            array_ubicacion[idCliente] = posicion[i];

                            if (typeof debug_ubicacion != null && debug_ubicacion == true){
                                console.log('Creado: ' + idCliente);
                            }

                        }else if (posicion[i].lat != array_ubicacion[idCliente].lat || posicion[i].lon != array_ubicacion[idCliente].lon){

                            array_ubicacion[idCliente].marcador.setPosition(new google.maps.LatLng(posicion[i].lat, posicion[i].lon));
                            if (typeof debug_ubicacion != null && debug_ubicacion == true){
                                console.log('Actualizad: ' + idCliente);
                            }
                        }else{
                            if (typeof debug_ubicacion != null && debug_ubicacion == true){
                                console.log('Omitido: ' + idCliente);
                            }
                        }
                        
                    };
                },
                error: function (){
                    alert('Error');
                }
            });

        }