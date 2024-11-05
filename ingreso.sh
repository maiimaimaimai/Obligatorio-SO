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
    echo "admin"
elif grep -q "^$userName $password$" clientes_usuarios.txt; then
    echo "cliente"
else 
    echo "Credenciales incorrectas, vuelva a intentar."
    login
fi
}

mascota_disponible() {
    while read -r line; do COMMAND "$line"; done < mascotas_disponibles.txt
}

mascota_adopcion() {

}

salir () {

}

menu_cliente() {
echo "1- Mascotas disponibles para adopción"
echo "2- Adoptar mascota"
echo "3- Salir"
read option
while [ "$option" != "1" ] || [ "$option" != "2" ] || [ "$option" != "3" ]; do
    echo "Opción no válida, vuelva a ingresar opción"
    read option
done
if (option == "1"); then
    mascota_disponible
elif (option == "2"); then
    mascota_adopcion
else 
    salir
fi

if $option == "1"; then
}

login
menu_cliente