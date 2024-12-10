#!/bin/bash
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


if grep -q "^$userName $password$" admin_usuarios.txt; then
    menu_administrador
elif grep -q "^$userName $password$" clientes_usuarios.txt; then
    echo "Menu Cliente:"
    menu_cliente
else 
    echo "Credenciales incorrectas, vuelva a intentar."
    login
fi
}

mascota_disponible() {
    while read -r line; do 
    echo "$line";
    done < mascotas_disponibles.txt
    # echo "aaaaa"    
}

mascota_adopcion() {
    index=1;
    while read -r line; do 
    if [ -z "$line" ]; then
            continue
        fi
    read -r name rest <<< "$line";
    echo "$index $name";
    ((index++));
    done < mascotas_disponibles.txt
    echo "Seleccione una mascota para adoptar:"
    read mascota
    while [ ! "$mascota" <= index ] && [ ! "$mascota" > 0 ]; do
        echo "Opción no válida, vuelva a intentar"
        read mascota
    done
}

salir () {
    echo "--------"
}

menu_cliente() {
echo "1- Mascotas disponibles para adopción"
echo "2- Adoptar mascota"
echo "3- Salir"
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
    salir
fi
}

menu_administrador() {
    clear
    echo "Menu Administrador:"
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
            salir
        fi
}

registrarUsuario(){
    clear
    echo "Registro de usuario:"
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
        else
            break
        fi
    done
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
    echo "Ingresar numero de telefono"
    read numero
    while true; do
        if [ -z "$numero" ]; then
            echo "No se ingresó un número"
            echo "Vuelva a ingresar un número"
            read numero
        elif ! echo "$numero" | grep -qE '^09[0-9]{7}$'; then
            echo "Se ingresó un caracter inválido. Solo caracteres numéricos permitidos (9)"
            echo "Vuelva a ingresar un número"
            read numero
        else 
            break
        fi
    done
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
    echo "Conceder permisos de administrador? (S/N)"
    read permisos
    while true; do
        if [ -z "$permisos" ]; then
            echo "No se ingresó una respuesta"
            echo "Intente nuevamente"
            read permisos
        elif ! echo "$permisos" | grep -qE '^[SsNn]$'; then
            echo "No se ingresó una respuesta válida"
            echo "Ingrese una respuesta válida (S/N)"
            read permisos
        else
            break
        fi
    done

    # checkear que no esté ni en usuarios ni en admin
    # luego meterlo a la de permisos correspondiente
    echo "Usuario registrado correctamente(mentira)"
    echo "usuario $nombre, con cedula $cedula, nacido el $fecha, número de contacto $numero"
    sleep 15
}

login
# menu_cliente