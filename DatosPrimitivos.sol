// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract DatosPrimitivos{
    //Datos Booleanos
    bool public isValid=true;
    bool public isInvalid; // deberia de mostrar el tipo de datos por defecto

    //Integer sin singnos
    uint8  public integer_u8 = 10;//Uint es un valor que se puede almacenar en un cajon
    uint48 private integer_u256 = 25673 ;   //Uint interno es un valor que solo puede ser accesado dentro de la misma clase (interna)
    uint public  u250= 300;
    uint public initial; //deberia de darnos el valor por defectoq ue se inicia una varibale

    //integers se puede manejar numeros positivos y negativos
    int8 public i8 = type(int8).max; // para saber el valor del uint 
    int256 public i256=12312313;
    int public i300 = 7182346;
    int public initialInteger=type(int256).max;

    //address
    address public myAddress=0x7F5861bcDe31bc88b071569cF9A3695A25E3c8FD;
    address public initialAddress; // el addres por defecto siempre sera 000000000000000..
}

contract Variables{
    string public textoEjemplo = "Curso Solidity";
    bool public isValid= true;

    function foo() public { //Funcion 
        //uint valor =3000;
        //valor =2000;

        //uint timestamp = block.timestamp;//timestamp del bloque osea asigan el tiempo real 
        //address sender = msg.sender;
    }
}
contract Constants{ // son varibales que siempre se utilizar en el contrato te ayuda a ahorrar gas
    address public constant myAddress=address(0);
    uint public  constant intaeres_rate = 2;
}

contract Inmutable{ //Estas variables con "inmutable" si o si tiene que iniciarse xq sino va a presentar errores
    //address public inmutable My_address;
    //uint256 public inmutable My_number;

    /*constructor(address _address, uint256 _number){
        My_address = _address;
        My_number = _number;
    }*/

}