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

## 📖 Guía de Uso

### Requisitos Previos
* Un emulador de MS-DOS como **DOSBox**, **emu8086**, o cualquier entorno compatible con interrupciones DOS (`INT 21h`).

### Uso del Sistema

**1. Compilación y Ejecución:**
1. Abra el emulador de su preferencia y ensamble el archivo fuente `BankTec.asm`.
2. Ejecute el binario generado (usualmente un archivo `.com` o `.exe`).

**2. Menú Principal:**
Al iniciar, el sistema desplegará un menú interactivo en la consola de texto con las siguientes opciones:
1. **Crear cuenta:** Solicita un número de cuenta nuevo, el nombre del titular y la inicializa con saldo 0 en estado Activa.
2. **Depositar dinero:** Solicita el número de cuenta y el monto positivo a sumar.
3. **Retirar dinero:** Solicita el número de cuenta y el monto a debitar (validando los fondos disponibles).
4. **Consultar saldo:** Muestra los detalles completos de una cuenta específica.
5. **Mostrar reporte general:** Despliega las estadísticas globales del sistema.
6. **Desactivar cuenta:** Cambia el estado de una cuenta de activa a inactiva.
7. **Salir:** Termina la ejecución de manera segura y regresa a la línea de comandos.

---

## 🛠️ Detalles Técnicos
* **Lenguaje:** Ensamblador 8086 (x86 Assembly).
* **Arquitectura:** Modular (uso intensivo de subrutinas con `CALL/RET`).
* **Manejo de I/O:** Interrupciones de DOS (`INT 21h`).
* **Procesamiento de Datos:** Estructuras simuladas tipo registro en memoria, algoritmos de búsqueda lineal y lógica condicional avanzada para validaciones y aritmética simulada de decimales.
