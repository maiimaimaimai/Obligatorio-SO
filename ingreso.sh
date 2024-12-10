#!/bin/bash
clear
login() {
echo "Nombre de usuario:"
read userName
while [ "$userName" == "" ]; do 
    echo "No se ingresó nombre de usuario"
    echo "Vuelva a ingresar nombre de usuario:"
    read userName
done

echo "Contrasena:"
read password
while [ "$password" == "" ]; do
    echo "No se ingresó contrasena"
    echo "Vuelva a ingresar contrasena:"
    read password
done


if grep -q "^$userName@$password@" admin_usuarios.txt; then
    menu_administrador "$userName" 
elif grep -q "^$userName@$password@" clientes_usuarios.txt; then
    menu_cliente "$userName"
else 
    echo "Credenciales incorrectas, vuelva a intentar."
    login
fi
}

mascota_disponible() {
    while IFS="-" read -r id especie nombre genero edad descripcion fecha; do 
    echo "$nombre - $especie - $edad - $descripcion";
    done < mascotas_disponibles.txt
    echo -e

    echo "Presione cualquier tecla para salir"
    echo "૮˶• ﻌ •˶ა
./づ~ 🦴"
    read opcion
    
    menu_cliente
}

mascota_adopcion() {
    index=1;
    while IFS="-" read -r id especie nombre genero edad descripcion fecha; do 
    if [ -z "$id" ]; then
        continue
    fi
    echo "$index $nombre";
    ((index++));
    done < mascotas_disponibles.txt
    echo "Seleccione una mascota para adoptar:"
    read mascota
    while [ "$mascota" -gt "$index" ] || [ "$mascota" -le 0 ]; do
        echo "Opción no válida, vuelva a intentar"
        read mascota
    done
    mascotaAdoptar=$(sed -n "${mascota}p" mascotas_disponibles.txt)
    echo "$mascotaAdoptar $(date '+%d/%m/%y')" >> adopciones.txt

    echo "Escriba \"si\" si desea confirmar la adopción"
    echo "૮˶• ﻌ •˶ა
./づ~ ♡"
    read confirmacion

    if [ "$confirmacion" = "si" ] || [ "$confirmacion" = "Si" ] || [ "$confirmacion" = "SI" ]; then
        sed -i "${mascota}d" mascotas_disponibles.txt
    fi

    menu_cliente

}

menu_cliente() {
clear
echo "˚ʚ♡ɞ˚MENU˚ʚ♡ɞ˚"
echo "1- Mascotas disponibles para adopción"
echo "2- Adoptar mascota"
echo "3- Salir"
echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣄⢀⣀⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣤⣤⣤⣤⣤⣤⣀⣀⠀⠀⠹⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣠⣴⠾⠛⠉⠉⠉⠀⠀⠀⠀⠀⠉⠉⠉⠛⠷⣶⣼⣿⣉⣁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⡾⠛⠉⠛⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⡏⠉⠙⠛⢶⣄⠀⠀⠀⠀⠀
⠀⠀⠀⢠⣾⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣿⣧⠀⠀⠀⠀
⠀⠀⢠⣿⠃⠀⠀⠀⠀⠀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠈⢿⡇⠀⠀⠀
⠀⠀⠹⣿⡎⠀⠀⠀⣠⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⢻⡆⠀⠀⣆⣿⡇⠀⠀⠀
⠀⠀⠀⣿⡀⠀⡀⠀⣿⠁⠀⢠⣾⣿⡿⠆⠀⠀⠀⠀⠀⠀⢀⣾⣿⡿⠆⠀⠀⠀⢈⣿⠀⣄⣾⡿⠁⠀⠀⠀
⠀⠀⠀⠘⣿⣧⣇⢀⣇⠀⠀⠘⣿⣿⣷⡆⠀⠀⠀⠀⠀⠀⠈⢿⣿⣷⠖⠀⠀⠀⢸⣿⣷⠿⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠉⠙⠻⣿⣆⡀⠀⠀⠉⠉⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣸⣿⠁⣀⣀⣀⠀⠀⠀⠀
⠀⢀⣠⡶⠾⠛⠓⠶⣿⡟⠀⠀⠀⠀⠀⠀⠠⣾⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⠟⠋⠉⠛⠻⣦⡀⠀
⢀⣾⠋⠀⠀⠀⠀⠀⠘⣿⣠⣄⡀⠀⠀⠀⠀⠛⠿⠟⠁⠀⠀⠀⠀⠀⡀⡀⠀⣴⣾⡏⠀⠀⠀⠀⠀⠈⣿⡄
⢸⣯⠀⢠⠀⠀⢀⣄⣠⣿⠿⢿⣷⣤⣦⣀⣤⣤⣤⣤⣀⣀⣀⣼⣆⣼⣷⣿⡾⠿⢿⣧⣀⣦⠀⠀⣤⠀⣸⡧
⠘⠿⣷⣾⣷⣤⠾⠿⠛⠁⠀⠀⠀⠁⠀⠉⠉⠀⠀⠀⠈⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠉⠛⠻⠷⠾⠿⠟⠛⠁" 
read option
while [ "$option" != "1" ] && [ "$option" != "2" ] && [ "$option" != "3" ]; do
    echo "Opción no válida, vuelva a ingresar opción"
    read option
done
if [ "$option" == "1" ]; then
    mascota_disponible
elif [ "$option" == "2" ]; then
    mascota_adopcion
else 
    exit
fi
}

menu_administrador() {
    clear
    echo "Menu Administrador - Bienvenido $1"
    echo "1- Registrar usuario"
    echo "2- Registrar mascota"
    echo "3- Ver estadisticas"
    echo "4- Salir"
    read option
    while [ "$option" != "1" ] && [ "$option" != "2" ] && [ "$option" != "3" ] && [ "$option" != "4" ]; do
        echo "Opción no válida, vuelva a ingresar opción"
        read option
        done
        if [ "$option" == "1" ]; then
            registrarUsuario
            menu_administrador
        elif [ "$option" == "2" ]; then
            registrarMascota
            menu_administrador
        elif [ "$option" == "3" ]; then
            verEstadisticas
            menu_administrador
        else 
            exit
        fi
}

registrarUsuario(){
    clear
    echo "Registro de usuario:"
    #ingreso de
    echo "Ingresar nombre"
    read nombre
    while true; do
        if [ -z "$nombre" ]; then
            echo "No se ingresó un nombre"
            echo "Vuelva a ingresar un nombre de usuario"
            read nombre
        elif echo "$nombre" | grep -qE '@'; then
            echo "Se ingresó un caracter inválido (@)"
            echo "Vuelva a ingresar un nombre de usuario"
            read nombre
        elif hayUsuarioNombre "$nombre"; then
            echo "Nombre de usuario ya existente"
            echo "Vuelva a ingresar un nombre de usuario"
            read nombre
        else
            break
        fi
    done

    #ingreso de
    echo "Ingresar cedula"
    read cedula
    while true; do
        if [ -z "$cedula" ]; then
            echo "No se ingresó una cedula"
            echo "Vuelva a ingresar una cedula"
            read cedula
        elif ! echo "$cedula" | grep -qE '^[0-9]{8}$'; then
            echo "Se ingresó un caracter inválido o faltan números. Solo caracteres numéricos permitidos (8)"
            echo "Vuelva a ingresar una cedula"
            read cedula
        else 
            break
        fi
    done

    #ingreso de
    echo "Ingresar numero de telefono"
    read numero
    while true; do
        if [ -z "$numero" ]; then
            echo "No se ingresó un número"
            echo "Vuelva a ingresar un número"
            read numero
        elif ! echo "$numero" | grep -qE '^[0-9]{9}$'; then
            echo "Se ingresó un caracter inválido. Solo caracteres numéricos permitidos (9)"
            echo "Vuelva a ingresar un número de telefono"
            read numero
        else 
            break
        fi
    done

    #ingreso de
    echo "Ingresar fecha (DD/MM/AAAA):"
    read fecha
    while true; do
        if [ -z "$fecha" ]; then
            echo "No se ingresó una fecha"
            echo "Vuelva a ingresar una fecha (DD/MM/AAAA)"
            read fecha
        elif ! echo "$fecha" | grep -qE '^([0-2]?[0-9]|3[01])/([0]?[1-9]|1[0-2])/([1-9][0-9]{3})$'; then
            echo "Formato inválido o valores fuera de rango"
            echo "Vuelva a ingresar una fecha (DD/MM/AAAA)"
            read fecha
        else
            break
        fi
    done

    #ingreso de
    echo "Conceder permisos de administrador? (S/N)"
    read permisos
    while true; do
        if [ -z "$permisos" ]; then
            echo "No se ingresó una respuesta"
            echo "Intente nuevamente"
            read permisos
        elif ! echo "$permisos" | grep -qE '^[SsNn]$'; then
            echo "No se ingresó una respuesta válida"
            echo "Conceder permisos de administrador? (S/N)"
            read permisos
        else
            break
        fi
    done

    #ingreso de
    echo "Ingrese una contraseña"
    read contra
    while true; do
        if [ -z "$contra" ]; then
            echo "No se ingresó una contraseña"
            echo "Ingrese una contraseña"
            read contra
        else
            break
        fi
    done

    #checkeo el tipo de usuario
    tienePermisos=""
    archivoUsuario=""
    if [ "$permisos" == "s" ] || [ "$permisos" == "S" ]; then
        tienePermisos="CON"
        archivoUsuario="admin_usuarios.txt"
    else
        tienePermisos="SIN"
        archivoUsuario="clientes_usuarios.txt"
    fi

    #confirmacion
    echo "Confirmar usuario ($nombre), con cédula ($cedula), nacido el ($fecha), número de contacto ($numero) $tienePermisos permisos de administrador? (S/N)"

    read confirmacion
    while true; do
        if [ -z "$confirmacion" ]; then
            echo "No se ingresó una respuesta"
            echo "Intente nuevamente"
            read confirmacion
        elif ! echo "$confirmacion" | grep -qE '^[SsNn]$'; then
            echo "No se ingresó una respuesta válida"
            echo "Confirma el ingreso del usuario? (S/N)"
            read confirmacion
        else
            break
        fi
    done

    if [ "$confirmacion" == "s" ] || [ "$confirmacion" == "S" ]; then
        echo "$nombre@$contra@$cedula@$fecha@$numero" >> "$archivoUsuario"
        echo "Usuario $nombre ingresado con éxito"
    else
        echo "Usuario cancelado"
    fi
    
    sleep 1.5
    echo "Ingrese X para volver al menú"
    
    read salir
    while true; do
        if ! echo "$salir" | grep -qE '^[xX]$'; then
            echo "No se ingresó una respuesta válida"
            echo "Ingrese X para volver al menú (S/N)"
            read salir
        else
            break
        fi
    done
}

hayUsuarioNombre(){
    if grep -q "^$1@" admin_usuarios.txt; then
        return 0
    elif grep -q "^$1@" clientes_usuarios.txt; then
        return 0
    fi
    return 1;
}

login
# menu_cliente