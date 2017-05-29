#!/bin/bash

DIR_BASE="/home/ubuntu/Escritorio/_me/crossdomain/"
DIR_LOGS="logs"
DIR_TMP="tmp"

FICH_ERROR="${DIR_BASE}${DIR_LOGS}/$(date +%Y%m%d).err"
FICH_BACKUP="${DIR_BASE}${DIR_LOGS}/$(date +%Y%m%d).backup"

EXTENSION=".zip"
NOMBRE_OLD=".old"
C_ZIP="zip -r"

C_CP="cp -r"

ruta_in=$1                     ## Ruta de entrada
subtexto_log=$2    
ruta_bck=${ruta_in}_$(date +%Y%m%d)$EXTENSION  ## Ruta backup

FICH_LOGS="${DIR_BASE}${DIR_LOGS}/$(date +%Y%m%d)_${subtexto_log}.log"

DIR_T_ONLINE="${DIR_BASE}${DIR_TMP}/online_${subtexto_log}"
DIR_T_ONLINET="${DIR_BASE}${DIR_TMP}/onlinet_${subtexto_log}"



####################################################################################

####################################################################################
# Definición de funciones generales del proceso
####################################################################################

traza(){
  echo "`date` : $1  "  >> "${FICH_LOGS}" 
}


error(){
  traza "$1"
  echo "`date` : $1  "  >> "${FICH_ERROR}"  
  exit 1
}

backup(){
  echo "`date` : $1  "  >> "${FICH_BACKUP}" 
}




copiarEstructura(){

  ficheroEntrada=$1
  
  traza "\tcopiarEstructura [$ficheroEntrada]"

  ## ####################################################################################  
   traza "\tCreamos carpeta temporal para trabajar ${DIR_T_ONLINE}"
  ## ####################################################################################
     
   mkdir $DIR_T_ONLINE  
   if [ $? != 0 ]
   then
      error "Se ha producido un error al intentar crear la carpeta temporal [mkdir ${DIR_T_ONLINE}]"  
   fi

  ## ####################################################################################  
   traza "\tCreamos carpeta temporal para trabajar ${DIR_T_ONLINET}"
  ## ####################################################################################
     
   mkdir $DIR_T_ONLINET 
   if [ $? != 0 ]
   then
      error "Se ha producido un error al intentar crear la carpeta temporal"  
   fi
   
   
  ## ####################################################################################
   traza "\tCopiamos ruta de entrada"
  ## ####################################################################################   
     cd ${DIR_T_ONLINE}
     
     ecomando=`${C_CP} ${ficheroEntrada} ${DIR_T_ONLINE}`
     if [ $? != 0 ]
     then
        error "Se ha producido un error al intentar copiar el fichero [${C_CP} "${ficheroEntrada}" ${DIR_T_ONLINE}]"  
     fi

}


generarZip(){

    ficheroSalida=$1

  traza "\tgenerarZip [$ficheroSalida]"
            
    cd ${DIR_T_ONLINE} 
    ecomando=`${C_ZIP} "${ficheroSalida}" *`
     if [ $? != 0 ]
     then
        error "Se ha producido un error al intentar zipear el fichero bck [$ficheroSalida]"  
     fi
  
  backup "${ficheroSalida}"
     
}


cambioNombreEstructura(){

  rutaEntrada=$1
  rutaSalida=$2

  traza "cambioNombreEstructura [$rutaEntrada $rutaSalida]"
  
   mv -fv "$rutaEntrada" "$rutaSalida" 
   if [ $? != 0 ]
   then
      error "Se ha producido un error al intentar cambiar el nombre [$rutaEntrada $rutaSalida]"  
   fi

}

eliminarTemporales(){

  traza "eliminarTemporales"

  cd $DIR_TMP

  ## ####################################################################################  
   traza "\tBorramos carpeta temporal ${DIR_T_ONLINE}"
  ## ####################################################################################
     
   #rmdir $DIR_T_ONLINE  
   if [ $? != 0 ]
   then
      error "Se ha producido un error al intentar borrar la carpeta temporal [rm -r ${DIR_T_ONLINE}]"  
   fi

  ## ####################################################################################  
   traza "\tBorramos carpeta temporal ${DIR_T_ONLINET}"
  ## ####################################################################################
     
   rmdir $DIR_T_ONLINET 
   if [ $? != 0 ]
   then
      error "Se ha producido un error al intentar borrar la carpeta temporal [rm -r ${DIR_T_ONLINET}]"   
   fi

}

eliminarEstructura(){

  ficheroEntrada=$1
  
  traza "eliminarEstructura [$ficheroEntrada]"
  
   rm -r "$ficheroEntrada"
   if [ $? != 0 ]
   then
      error "Se ha producido un error al intentar borrar el directorio [$ficheroEntrada]"  
   fi

}


cambioPermisos(){

 traza  "\cambioPermisos [${DIR_T_ONLINE}]"

    chmod -R 775 "${DIR_T_ONLINE}"    
    if [ $? != 0 ] 
    then
        error "Se ha producido un error al intentar cambiar los permisos de los ficheros [${DIR_T_ONLINE}]"
    fi

}


#####################


restaurarJQueryControljs(){

	traza "restaurarJQueryControljs [${DIR_T_ONLINE}]"

	for f in $(find ${DIR_T_ONLINE} -name "data0.xml" ); do

		folder=$(dirname $f)

		for j in $(find $folder -name "jquery.control.js" -exec grep -l "if(false)" {} \;); do

			traza "$j"

			sed 's/if(false)/if(currentIndex!=pantallas)/' "$j" > "${DIR_T_ONLINET}/jquery.control.js"
			if [ $? != 0 ] 
		    then
		        error "Se ha producido un error al intentar modificar el fichero $f "
		    fi 

			dirobjetivo="$(dirname "$j")"


		    traza "rm $j"
        rm "$j"    
		    if [ $? != 0 ] 
		    then
		        error "Se ha producido un error al intentar borrar el fichero $j"
		    fi
		    
		    traza "mv $j"
		 	mv "${DIR_T_ONLINET}/jquery.control.js" "$j"
		    if [ $? != 0 ] 
		    then
		        error "Se ha producido un error al intentar mover el fichero [mv ${DIR_T_ONLINET}/jquery.control.js $j] "
		    fi

		done

	done

}







################################################################################################

traza " Copia de la estructura recibida por parámetro" 
################################################################################################

     copiarEstructura "$ruta_in/*"
     

traza " Generación de fichero zip con la estructura recibida" 
################################################################################################

    generarZip "$ruta_bck"


traza " Restaurarción de ficheros jquery.control.js"
################################################################################################

	restaurarJQueryControljs


################################################################################################
traza " Eliminación de la estructura recibida" 
################################################################################################

    eliminarEstructura "$ruta_in"


################################################################################################
traza " Cambio de permisos archivos" 
################################################################################################

    cambioPermisos 

################################################################################################
traza " Cambio de nombre de la estructura generada" 
################################################################################################

    cambioNombreEstructura "${DIR_T_ONLINE}" "$ruta_in"

################################################################################################
traza " Borrado carpetas temporales" 
################################################################################################

    eliminarTemporales
    
    
################################################################################################
traza " Finalización proceso " 
################################################################################################

  exit 0;