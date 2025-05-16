// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract condicionales {
    function foo(uint numero) public pure returns (uint) {
        if (numero<100){
             return 0;
        }else if (numero>200){
            return 1;
        }else{
            return 2;
        }
    }
    function ternary(uint numero) public pure returns (uint) {
        return (numero < 10 ? 1:2);
    }
}