// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
contract AccederYModificarDatos{
    address private myAddress;
    uint256 public myNumber;

    function setNumber(uint256 _myNumber)public {// para modificar un dato con set
        myNumber = _myNumber;
    }

    function getMyNumber() public view returns (uint256){  //view para ver un solo dato
       return myNumber;
    }

    function getMyAddress() public view returns (address){  //view para ver un solo dato
       return myAddress;
    }

    function getSender() public  view returns(address){ //Envia el address del contrato
        return msg.sender;
    }

    function getTimestamp() public view returns (uint){ //l tiempo actual a cada rato se actualiza
        return block.timestamp;
    }
}