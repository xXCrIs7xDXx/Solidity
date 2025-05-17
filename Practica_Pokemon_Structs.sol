// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract PokemonStructs {
    struct pokemon{
        string nombre;
        string tipoPrimario;
        string tipoSecundario;
        uint peso;
        uint altura;
        uint nivel;
    }

    pokemon[] private pokemons;
    
    //Crea el pokemon por datos por defecto 
    function crearPokemon()public {
        pokemons.push(pokemon("Incineroar", "Fuego", "Lucha", 83, 180,50));
    }

    //Crea el pokemon por datos ingresados por teclado 
    function crearPokemon(string memory _nombre, string memory _tipoPrimario, string memory _tipoSecundario, uint _peso ,uint _alt, uint _nivel ) public {
        pokemons.push(pokemon(_nombre,_tipoPrimario, _tipoSecundario,_peso,_alt,_nivel));
    }

    //Modifica el nivel del pokemon 
    function SubirNivel(uint _index, uint _nivel)public{
        pokemon storage p = pokemons[_index];
        p.nivel = _nivel;
    }

    //Muestra al pokemon
    function get (uint _index) public view returns(pokemon memory){
        return pokemons[_index];
    }

    //Numero de Pokemons que tengo
    function NumeroPokemons()public view returns (uint){
        return pokemons.length;
    }
    
}