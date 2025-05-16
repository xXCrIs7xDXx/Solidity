// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Array{
    uint[] public arr;
    uint[] public arrTwo = [0,1,2]; // Recuerda que las arrayas siempre comienzan en cero

    uint[8] public arrayConTamanio;

    //Muestra los valores del array
    function getArray() public view returns(uint[] memory){
        return arr;
    } 

    // Agrega Valores al array 
    function push(uint _i) public {
        arr.push(_i);
    }

    //Elimina el ultimo elemento del array osea:
    //[1,2,3] ahora sera [1,2]
    function pop() public {
        arr.pop();
    }

    //Muestra cuantos elementos tiene el array
    //[1,2,3,4,5] = el tamanio es 5
    function getlength() public view returns (uint){
        return arr.length;
    }

    //Elimina el valor o indice que le mandes recuerda que siempre comienza en cero
    // [1,2,3,4] = Si eliminamos el 0 se borrara el 1
    // [1,2,3,4] = [0,2,3,4]
    function removeFromArray(uint _i) public {
        delete arr[_i];
    }

    function createArray() public pure returns(uint[] memory){
        uint[] memory a = new uint[](3);
        return a;
    }
}