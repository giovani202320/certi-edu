// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Certificados {
    
    struct Certificado {
        string nombre_titular;     
        string codigo_certificado; 
        uint256 fecha_emision;     
        bool estado_validez;       
    }

    address public admin;
    mapping(string => Certificado) private certificados;

    modifier soloAdmin() {
        require(msg.sender == admin, "No eres el administrador autorizado");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /**
     * @dev Valida estrictamente que el código cumpla con el formato "UNSA-XXXXXXXX" (13 caracteres en total)
     * donde las últimas 8 posiciones deben ser dígitos numéricos (CUI).
     */
    function validarFormatoCodigo(string memory _codigo) internal pure returns (bool) {
        bytes memory b = bytes(_codigo);
        
        // 1. Validar longitud exacta: "UNSA-" (5 chars) + 8 dígitos del CUI = 13 caracteres
        if (b.length != 13) return false;

        // 2. Validar prefijo institucional "UNSA-" de forma estricta
        if (b[0] != "U" || b[1] != "N" || b[2] != "S" || b[3] != "A" || b[4] != "-") return false;

        // 3. Validar que los caracteres del índice 5 al 12 sean números (valores ASCII entre '0' y '9')
        for (uint i = 5; i < 13; i++) {
            if (b[i] < "0" || b[i] > "9") return false;
        }

        return true;
    }

    // CREATE: Registrar nueva certificación con validación de patrón estricta
    function registrar(string memory _codigo, string memory _nombre) public soloAdmin {
        // Ejecuta el filtro de formato antes de tocar el almacenamiento
        require(validarFormatoCodigo(_codigo), "Formato invalido. Debe ser UNSA-XXXXXXXX (Donde X es el CUI)");
        require(!certificados[_codigo].estado_validez, "Este certificado ya fue registrado previamente");

        certificados[_codigo] = Certificado({
            nombre_titular: _nombre,
            codigo_certificado: _codigo,
            fecha_emision: block.timestamp, 
            estado_validez: true            
        });
    }

    // READ / VALIDATE: Verificar el contenido
    function verificar(string memory _codigo) public view returns (string memory nombre, uint256 fecha, bool valido) {
        Certificado memory cert = certificados[_codigo];
        return (cert.nombre_titular, cert.fecha_emision, cert.estado_validez);
    }

    // DELETE LOGIC: Revocar certificación
    function eliminarorevocar(string memory _codigo) public soloAdmin {
        require(certificados[_codigo].estado_validez, "El certificado no existe o ya esta inactivo");
        certificados[_codigo].estado_validez = false;
    }
}