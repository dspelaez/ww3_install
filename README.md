# Instalación de las bibliotecas NetCDF4-Fortran

Las bibliotecas de NetCDF4-Fortran tiene como prerequisito las bibliotecas de `zlib`, `HDF5` y `NetCDF4-C`. Lo primero que debemos hacer es instalar el compilador de C y de Fortran, que en el caso de estar usando Linux (Ubuntu) lo más recomendable es instalarlo con:

```
sudo apt install gfortran g++ m4
```

Para MacOSX lo más recomendable es usar el que viene en el [Homebrew](https://brew.sh/index_es), para eso, simplemente escribimos

```
brew install gfortran m4
```

El siguiente paso es instalar las dependencias y las bibliotecas como tal, lo cual está automatizado en el script `install_netcdf.sh`. Este script nos preguntará dónde están los compiladores que vamos a usar. En el caso de MacOSX generalmente es `FC=/usr/local/bin/gfortran` y `CC=/usr/bin/gcc`. Si estamos usando Linux, sería `FC=/usr/bin/gfortran` y `CC=/usr/bin/gcc`.

Al ejecutar este script se instalarán todas las bibliotecas en la ruta `NCDIR=/usr/local/netcdf`, por lo tanto tengo que agregar dicha ruta a la variable de entorno `DYLD_LIBRARY_PATH` en MacOSX y `LD_LIBRARY_PATH` en Linux, es decir, agrego al `.profile` lo siguiente:

```
export LD_LIBRARY_PATH=$NCDIR/lib:$LD_LIBRARY_PATH
```

o

```
export DYLD_LIBRARY_PATH=$NCDIR/lib:$DYLD_LIBRARY_PATH
```

dependiendo del caso.


# Compilación del modelo WAVEWATCH III 5.16
El modelo WAVEWATCH III 5.16 es bastante amigable a la hora de instalar y de compilar. Lo primero es descargar el `.tar`
de la página de la NOAA con el código fuente. Lo ponemos en nuestro directorio de trabajo y lo descomprimimos con 

```
tar -xf wwatch3.v5.16.tar.gz
```

Ahí se generará un script llamado `install_ww3_tar` que nos guiará en la instalación. Las opciones que yo le pongo son:

- Hago una instalación local, es decir, me genera un archivo en `${WW3DIR}/wwatch3.env`, esto es para que podamos tener 
varias versiones del modelo en el mismo computador.
- Cuando pregunta por los compiladores le pongo las rutas completas de donde están el `gcc` y el `gfortran`.

Una vez haya instalado el modelo hay que agregar al `~/.profile` las rutas donde quedó instalado el modelo. En mi caso es:

```
export WW3DIR=$HOME/Models/ww3/5.16
```

Debemos modificar los archivos `comp`, `link` y `switch`. En este caso yo quiero instalar el WW3 en serie y con soporte para NetCDF4, entonces primero debo editar el archivo `switch` para incluir dichas especificaciones:

```
cd $WW3DIR/bin/
vim switch
```

y agrego la clave `NC4`. Luego hago una copia de las archivos `comp` y `link` que vienen con el sufijo `.gnu`, es decir

```
cp comp.gnu comp
cp link.gnu link
```

Adicionalmente para instalar con NetCDF4 necesitamos agregar las siguientes variables de entorno:

```
export WWATCH3_NETCDF=NC4
export NETCDF_CONFIG=$NCDIR/bin/nf-config
```

donde generalmente `$NCDIR=/usr/local/netcdf` si usamos el scritpt `install_netcdf.sh`.

Finalmente podemos hacer la prueba de que quedó bien compilado que viene en el [manual](http://polar.ncep.noaa.gov/waves/wavewatch/manual.v5.16.pdf)

```
ln3 ctest
ad3 test ctest
ad3 ctest 1
```

Si todo sale bien ya podremos compilar el modelo sin problema ejecutando

```
$WW3DIR/bin/w3_make
```

Si sale un error en la compilación, hacemos las modificaciones pertinentes y luego generamos una nueva compilación con

```
$WW3DIR/bin/w3_clean
$WW3DIR/bin/w3_new
$WW3DIR/bin/w3_make
```
