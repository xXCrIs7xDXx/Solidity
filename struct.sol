// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Struct{

    struct Games{
        string description;
        bool played;
    }

    Games[] private games;

    // Get the number of games in the array
    function getArrayLength() public view returns (uint) {
        return games.length;
    }

    //Muestra lo que hay en el array
    function get (uint _index) public view returns(Games memory){
        return games[_index];
    }

    function createGame(string memory _description) public {
        //Cualquiera de estas funciones se puede usar para crear algo
        games.push(Games(_description, false));

        /*games.push(Games({description: _description,played: false}));

        Games memory game;
        game.description=_description;
        game.played=true;
        games.push(game);*/
    }

    //Cambia o modifica la descripcion 
    function updateDescription(uint _index, string memory _description) public{
        Games storage game= games[_index];
        game.description=_description;
    }

    //Poner el contrario del Boolean 
    function setOpposite(uint _index)public {
        Games storage game = games[_index];
        game.played = !game.played;
    }
    
}