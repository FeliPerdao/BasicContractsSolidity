# 📝 Contrato Mensaje - Solidity

Este es un contrato inteligente básico escrito en Solidity que permite guardar y consultar un mensaje en la blockchain.  
Cada vez que el mensaje se actualiza, se emite un evento `Mensaje_MensajeActualizado`.

> ⚠️ **Aviso:** este contrato es únicamente con fines educativos. No debe usarse en entornos productivos.

---

## 📖 Descripción

El contrato `Mensaje`:

- Almacena un `string` en la blockchain.
- Permite actualizar el mensaje mediante la función `setMensaje`.
- Emite un evento cada vez que se cambia el mensaje.
- Permite leer el último mensaje almacenado con `getMensaje`.

---

## 📂 Estructura del repositorio

```bash
├── contracts/
│ └── Mensaje.sol
├── .gitignore
├── README.md
```

---

## 🚀 Cómo clonar y ejecutar en un IDE

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/FeliPerdao/contrato-mensaje.git
   cd contrato-mensaje

   ```

2. Abrir el proyecto en Remix IDE
   o en un IDE local (ej. VS Code) con Hardhat o Foundry configurado.

3. Compilar el contrato con Solidity ^0.8.0.

4. Desplegarlo en una testnet (ejemplo: Sepolia) usando Metamask.

---

## 🔗 Contrato en Testnet (Sepolia)

Dirección del contrato: 0x8115c1c8fE94A6D568f43De4eAF43E6CC3c57322

Explorer: Ver en Sepolia Etherscan https://sepolia.etherscan.io/address/0x8115c1c8fE94A6D568f43De4eAF43E6CC3c57322

---

## 👤 Autor

FeliPerdao
