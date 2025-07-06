// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Sistema de Votación Electoral Descentralizado
/// @author Cristian
/// @notice Este contrato permite registrar candidatos, autorizar votantes, emitir votos, delegar votos y consultar resultados.
contract Elecciones {

    /// @notice Representa a un candidato con su nombre y número de votos.
    struct Candidato {
        uint id;
        string nombre;
        uint votos;
    }

    /// @notice Representa a un votante con su estado de autorización, si ya votó y si ha delegado su voto.
    struct Votante {
        bool autorizado;
        bool yaVoto;
        uint votoCandidatoId;
        address delegado;
    }

    /// @notice Estados del ciclo electoral: preparación, votación y finalización.
    enum EstadoEleccion { Preparacion, Votacion, Finalizada }
    EstadoEleccion public estadoActual;

    address public admin;
    Candidato[] public candidatos;
    mapping(address => Votante) public votantes;

    /// @notice Eventos para seguimiento desde el frontend.
    event VotoEmitido(address votante, uint idCandidato);
    event VotoDelegado(address de, address a);
    event EleccionFinalizada(uint idGanador, string nombreGanador, uint totalVotos);

    /// @notice Verifica que solo el administrador pueda ejecutar funciones sensibles.
    modifier soloAdmin() {
        require(msg.sender == admin, "No tienes permisos de administrador.");
        _;
    }

    /// @notice Verifica que la función se ejecute en la fase adecuada del proceso electoral.
    modifier enEstado(EstadoEleccion _estado) {
        require(estadoActual == _estado, "Funcion no permitida en esta fase.");
        _;
    }

    /// @notice Constructor: define al administrador y pone el sistema en fase de Preparacion.
    constructor() {
        admin = msg.sender;
        estadoActual = EstadoEleccion.Preparacion;
    }

    /// @notice Permite al admin registrar un nuevo candidato.
    function registrarCandidato(string memory _nombre) public soloAdmin enEstado(EstadoEleccion.Preparacion) {
        candidatos.push(Candidato(candidatos.length, _nombre, 0));
    }

    /// @notice Autoriza a una dirección para emitir voto.
    function autorizarVotante(address _votante) public soloAdmin enEstado(EstadoEleccion.Preparacion) {
        votantes[_votante].autorizado = true;
    }

    /// @notice Cambia la fase a Votación. Solo se puede hacer si hay al menos un candidato.
    function iniciarVotacion() public soloAdmin enEstado(EstadoEleccion.Preparacion) {
        require(candidatos.length > 0, "Debe haber al menos un candidato.");
        estadoActual = EstadoEleccion.Votacion;
    }

    /// @notice Finaliza la elección y emite un evento con el ganador.
    function finalizarVotacion() public soloAdmin enEstado(EstadoEleccion.Votacion) {
        estadoActual = EstadoEleccion.Finalizada;
        (uint idGanador,,) = obtenerGanador();
        emit EleccionFinalizada(idGanador, candidatos[idGanador].nombre, candidatos[idGanador].votos);
    }

    /// @notice Permite a un votante autorizado emitir su voto a un candidato.
    function votar(uint _idCandidato) public enEstado(EstadoEleccion.Votacion) {
        Votante storage sender = votantes[msg.sender];
        require(sender.autorizado, "No estas autorizado.");
        require(!sender.yaVoto, "Ya has votado.");
        require(_idCandidato < candidatos.length, "Candidato no valido.");

        sender.yaVoto = true;
        sender.votoCandidatoId = _idCandidato;
        candidatos[_idCandidato].votos++;

        emit VotoEmitido(msg.sender, _idCandidato);
    }

    /// @notice Permite delegar tu voto a otra dirección de confianza.
    function delegarVoto(address _aQuien) public enEstado(EstadoEleccion.Votacion) {
        Votante storage delegante = votantes[msg.sender];
        require(delegante.autorizado, "No estas autorizado.");
        require(!delegante.yaVoto, "Ya has votado.");
        require(_aQuien != msg.sender, "No puedes delegarte a ti mismo.");

        address delegadoActual = _aQuien;

        // Evitar delegación circular (A → B → C → A)
        while (votantes[delegadoActual].delegado != address(0)) {
            delegadoActual = votantes[delegadoActual].delegado;
            require(delegadoActual != msg.sender, "Delegacion circular detectada.");
        }

        delegante.yaVoto = true;
        delegante.delegado = _aQuien;

        Votante storage destinatario = votantes[delegadoActual];

        if (destinatario.yaVoto) {
            // Si el delegado ya votó, el voto del delegante se suma directamente
            candidatos[destinatario.votoCandidatoId].votos++;
        }

        emit VotoDelegado(msg.sender, _aQuien);
    }

    /// @notice Devuelve la lista completa de candidatos.
    function verCandidatos() public view returns (Candidato[] memory) {
        return candidatos;
    }

    /// @notice Retorna el candidato con más votos. Solo se puede llamar si la elección ha finalizado.
    function obtenerGanador() public view enEstado(EstadoEleccion.Finalizada) returns (uint idGanador, string memory nombre, uint votos) {
        uint maxVotos = 0;
        uint ganadorId = 0;

        for (uint i = 0; i < candidatos.length; i++) {
            if (candidatos[i].votos > maxVotos) {
                maxVotos = candidatos[i].votos;
                ganadorId = i;
            }
        }

        return (ganadorId, candidatos[ganadorId].nombre, candidatos[ganadorId].votos);
    }
}
