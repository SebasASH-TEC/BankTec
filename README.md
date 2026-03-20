# BankTec 🏦

![Platform](https://img.shields.io/badge/Platform-DOS-blue)
![Language](https://img.shields.io/badge/Language-Assembly_8086-purple)
![Status](https://img.shields.io/badge/Status-Completed-green)

BankTec es un sistema interactivo de gestión bancaria desarrollado completamente en lenguaje Ensamblador 8086. La aplicación permite administrar hasta 10 cuentas de usuario, aplicando estructuras de memoria, procedimientos modulares, arreglos estructurados y validaciones de entrada para simular operaciones bancarias reales en un entorno de bajo nivel.

---

## 🚀 Funcionalidades

### 1. Gestión de Cuentas
El sistema soporta una capacidad máxima de 10 cuentas bancarias en memoria. Cada cuenta almacena internamente:
* **Número de cuenta:** Entero único validado para evitar duplicados.
* **Nombre del titular:** Cadena de texto (máximo 20 caracteres).
* **Saldo:** Sistema de enteros que simula una precisión de hasta 4 decimales.
* **Estado:** Indicador de cuenta Activa o Inactiva.

### 2. Operaciones Bancarias
* 💰 **Depósitos y Retiros:** Permite ingresar o deducir fondos. El sistema valida que la cuenta exista, que se encuentre en estado "Activa" y previene sobregiros mostrando advertencias si hay fondos insuficientes en un retiro.
* 🔒 **Desactivar Cuenta:** Permite cambiar el estado de una cuenta a inactiva (incluye validación para evitar intentar desactivar una cuenta que ya lo está).
* 🔍 **Consulta de Saldo:** Búsqueda por número de cuenta para revisar el estado actual de los fondos y los datos del titular.

### 3. Reporte General
Genera un análisis estadístico global del estado del banco, mostrando:
* Cantidad total de cuentas activas e inactivas.
* Saldo total almacenado en todo el banco.
* La cuenta con el **mayor** saldo y la cuenta con el **menor** saldo.

---

## 🛠️ Detalles Técnicos
* **Lenguaje:** Ensamblador 8086 (x86 Assembly).
* **Arquitectura:** Modular (uso intensivo de subrutinas con `CALL/RET`).
* **Manejo de I/O:** Interrupciones de DOS (`INT 21h`).
* **Procesamiento de Datos:** Estructuras simuladas tipo registro en memoria, algoritmos de búsqueda lineal y lógica condicional avanzada para validaciones y aritmética simulada de decimales.
