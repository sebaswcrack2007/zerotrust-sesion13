# Taller Sesión 13: Ciberseguridad Distribuida y Zero Trust (UNIAJC)

Implementación de tres controles reales de arquitectura Zero Trust sobre escenarios distribuidos:
1. **MetroMIO-IoT (Reto 1):** PKI interna con OpenSSL y autenticación mutua TLS 1.3 (mTLS) en Nginx.
2. **HospitValle UCI (Reto 2):** Cifrado de volúmenes en reposo con LUKS2 (AES-256-XTS), gestión de secretos con SealedSecrets y endurecimiento de Pods (`SecurityContext`, RBAC y Pod Security Admission `restricted`).
3. **AgroSugar AgTech (Reto 3):** Microsegmentación de red en Kubernetes mediante Calico CNI (`default-deny-all` + listas blancas L3/L4).

## Requisitos del entorno
- Ubuntu 22.04 / 24.04 (VM Linux con soporte `dm-crypt` / `aes-ni`)
- Docker Engine 24+, `kubectl`, `kind` v0.30.0+, CNI Calico v3.31.4+
- `openssl` 3.x, `cryptsetup` 2.4+, `kubeseal` 0.40.0+

## Orden de ejecución
1. **Clúster base:** `kind create cluster --config kind-zerotrust.yaml` + despliegue de Calico.
2. **Reto 1 (mTLS):** Ejecutar `./reto1-mtls/scripts/emitir-bus.sh 102 105`, levantar Nginx con `reto1-mtls/nginx/nginx.conf` en puerto `8443` y validar con `curl --cacert --cert --key`.
3. **Reto 2 (LUKS2 + K8s):** Formatear volumen con `cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --key-size 512 --pbkdf argon2id` y aplicar manifiestos `reto2-hospitvalle/k8s/00-*.yaml` a `03-*.yaml`.
4. **Reto 3 (NetworkPolicy):** Aplicar `reto3-agrosugar/k8s/01-escenario.yaml` y `02-networkpolicies.yaml`; validar conectividad con `./reto3-agrosugar/scripts/matriz.sh`.

## Integrantes y Roles
- **Sebastián Vélez Maquillo:** Líder técnico / Documentador / Auditor / Gestor de repositorio *(ajustar nombres si es en equipo)*.
