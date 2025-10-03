// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Contrato Mensaje
 * @author FeliPerdao
 * @notice Este contrato es mi primer proyecto del ethkipu
 * @custom:security Este contrato es educativo y no debe ser usado con fines productivos
 */

contract Mensaje {
    string s_mensaje;

    //Evento emitido cuando el mensaje es actualizado
    event Mensaje_MensajeActualizado(string mensaje);

    //Función para almacenar un mensaje en la blockchain
    function setMensaje(string memory _mensaje) external {
        s_mensaje = _mensaje;

        emit Mensaje_MensajeActualizado(_mensaje);
    }

    //Función get para devolver el mensaje almacenado
    function getMensaje() public view returns(string memory mensaje_){
        mensaje_ = s_mensaje;
    }
}   