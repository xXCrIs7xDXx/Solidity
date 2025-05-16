// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract gas{
    uint public index=0;

    function forever()public { //El gas es lo que necesitamos para hacer correr un contrato
        while(true){
            index+=1;
        }
    }
}