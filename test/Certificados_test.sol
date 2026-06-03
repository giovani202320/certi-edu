// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 1. Importamos la librería nativa de pruebas de Remix
import "remix_tests.sol";

// 2. Importamos tu contrato usando la carpeta REAL de tu explorador ("contratos")
import "../contratos/Certificados.sol";

contract CertificadosTest {
    Certificados certificadosInstancia;

    // Se ejecuta automáticamente antes de cada prueba
    function beforeEach() public {
        certificadosInstancia = new Certificados();
    }

    // Prueba 1: Verificar el administrador inicial 0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3
    function testInicializacionAdmin() public {
        Assert.equal(certificadosInstancia.admin(), msg.sender, "El creador deberia ser el admin");
    }

    // Prueba 2: Verificar el registro y validacion
    function testRegistrarYVerificar() public {
        string memory codigo = "INF-2026";
        string memory alumno = "Alejandro Torres";

        certificadosInstancia.registrarCertificado(codigo, alumno);

        (string memory nombreObtenido, bool esValido, ) = certificadosInstancia.verificarCertificado(codigo);

        Assert.equal(nombreObtenido, alumno, "El nombre del alumno no coincide");
        Assert.equal(esValido, true, "El estado del certificado deberia ser valido");
    }
}