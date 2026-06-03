# CertiEdu Digital - Validación de Certificados en Blockchain

Prototipo funcional de un contrato inteligente desarrollado en Solidity para resolver el fraude documental en certificaciones profesionales, garantizando inmutabilidad, trazabilidad y auditoría global descentralizada.

## 🚀 Estructura del Proyecto

- `contratos/Certificados.sol`: Contrato inteligente principal con reglas estrictas de consistencia para el formato de identificadores (`UNSA-XXXXXXXX`).
- `test/Certificados_test.sol`: Scripts de pruebas unitarias automatizadas para la máquina virtual de Ethereum (EVM).

## 🛠️ Tecnologías Utilizadas

- **Solidity (^0.8.0)**: Lenguaje de programación de contratos inteligentes.
- **Remix IDE**: Entorno de desarrollo integrado para la compilación y pruebas virtuales.
- **Remix VM (Cancun)**: Entorno blockchain simulado para la ejecución de transacciones.

## 📋 Reglas de Negocio Implementadas

1. **Gobernanza Centralizada:** Solo la dirección asignada como `admin` (Emisor institucional) puede registrar o revocar certificados.
2. **Validación de Formato On-Chain:** El identificador del certificado es auditado a nivel de bytes para forzar rigurosamente el patrón institucional `UNSA-XXXXXXXX`, donde las últimas 8 posiciones corresponden al CUI del estudiante.
3. **Persistencia Inmutable:** Los certificados no se eliminan físicamente; se inactivan lógicamente mediante la bandera `estado_validez = false` (Revocación), manteniendo el histórico criptográfico para auditorías permanentes.