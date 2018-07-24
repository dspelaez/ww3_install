El modelo WAVEWATCH III 5.16 es bastante amigable a la hora de instalar y de compilar, pero tiene ciertos trucos con los que debemos enfrentarnos. Lo primero es descargar el `.tar` de la página de la NOAA con el código fuente. Lo ponemos en nuestro directorio de trabajo y lo descomprimimos con 
```
tar -xf wwatch3.v5.16.tar.gz
```

Ahí se generará un script llamado `install_ww3_tar` que nos guiará en la instalación. Las opciones que yo le pongo son:
- Hago una instalación global, es decir, me genera un archivo en `${HOME}/.wwatch3.env`. Intenté una vez con una instalación local pero no me funcionó bien.
- Cuando pregunta por los compiladores le pongo `/usr/local/bin/gfortran` para el `F77` y el `/usr/bin/gcc` para el `CC`.

Una vez haya instalado el modelo hay que agregar al `~/.profile` las rutas de los ejecutables y binarios, suponiendo que `WW3DIR` es nuestra ruta de instalación, entonces agregamos:

```
export PATH=${WW3DIR}/exe:$PATH
export PATH=${WW3DIR}/bin:$PATH
```

Ahora llega la parte truculenta. Debemos modificar los archivos `comp`, `link` y `switch`. En este caso yo quiero instalar el WW3 en paralelo y con NetCDF4, entonces primero debo editar el archivo `switch` para incluir dichas especificaciones:

```
vim ${WW3DIR}/bin/switch
```

Agrego la clave `NC4`. Adicionalmente para instalar con NetCDF4 necesitamos agregar las siguientes variables de entorno:

```
export WWATCH3_NETCDF=NC4
export NETCDF_CONFIG=/usr/local/bin/nc-config
```

Finalmente podemos hacer la prueba de que quedó bien compilado que viene en el [manual](http://polar.ncep.noaa.gov/waves/wavewatch/manual.v4.18.pdf)

```
ln3 ctest
ad3 test ctest
ad3 ctest 1
```

Si todo sale bien ya podremos compilar el modelo sin problema ejecutando

```
w3_make
```
