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
    clear
    echo "admin"
elif grep -q "^$userName $password$" clientes_usuarios.txt; then
    clear
    echo "cliente"
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

salir () {
exit;
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
    salir
fi

# menu_administrador() {
# echo "1- Registrar usuario"
# echo "2- Registrar mascota"
# echo "3- Salir"
# read option
# while [ "$option" != "1" ] && [ "$option" != "2" ] && [ "$option" != "3" ]; do
#     echo "Opción no válida, vuelva a ingresar opción"
#     read option
#     done
#     if [ "$option" == "1" ]; then
#         # TODO
#     elif [ "$option" == "2" ]; then
#         # TODO
#     else 
#         salir
#     fi
# }
# if $option == "1"; then
# 
# fi
}

login
menu_cliente