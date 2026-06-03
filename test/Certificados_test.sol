// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";
import "../contratos/Certificados.sol";

contract CertificadosTest {
    Certificados certificadosInstancia;

    // Se ejecuta automáticamente antes de cada prueba para desplegar un contrato nuevo y limpio
    function beforeEach() public {
        certificadosInstancia = new Certificados();
    }

    // Prueba 1: Verificar que el creador del contrato se registra correctamente como admin
    function testInicializacionAdmin() public {
        Assert.equal(certificadosInstancia.admin(), msg.sender, "El creador deberia ser el admin");
    }

    // Prueba 2: Verificar que el flujo de registro exitoso y validacion funciona bajo el nuevo formato
    function testRegistrarYVerificar() public {
        // Usamos un formato valido: prefijo UNSA- mas un CUI ficticio de 8 digitos
        string memory codigoValido = "UNSA-20261405"; 
        string memory alumno = "Alejandro Torres";

        // Llamamos a la funcion corregida "registrar"
        certificadosInstancia.registrar(codigoValido, alumno);

        // Llamamos a la funcion corregida "verificar"
        (string memory nombreObtenido, , bool esValido) = certificadosInstancia.verificar(codigoValido);

        // Validamos los resultados
        Assert.equal(nombreObtenido, alumno, "El nombre del alumno no coincide");
        Assert.equal(esValido, true, "El estado del certificado deberia ser valido");
    }
}