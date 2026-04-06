# Sumcrowds Infra

Infrastructure-as-code for deploying **Sumcrowds** using **OpenTofu** (Terraform-compatible).

This repository defines and manages the full stack required to run the application in both development and production environments.

---

## 🧱 Overview

This repo provisions the core infrastructure for Sumcrowds, including:

* Backend services
* Frontend hosting
* PostgreSQL database
* NATS messaging system
* Ingress / routing
* Environment-specific configurations (dev & prod)

It uses **OpenTofu** to declaratively define and manage resources.

---

## 🌍 Environments

### Development (`dev`)

* Used for local/testing deployments
* Separate infrastructure stack
* Safer for experimentation

### Production (`prod`)

* Full production deployment
* Includes additional components (e.g. `marketing.tf`)
* Uses production-grade resources and secrets

---

## ⚙️ Prerequisites

* [OpenTofu](https://opentofu.org/) (or Terraform-compatible CLI)
* Cloud provider credentials (depending on your setup)
* Shell access (for running scripts)

---

## 🔐 Secrets Management

Secrets are handled via shell scripts:

```bash
scripts/secretsdev.sh
scripts/secretsprod.sh
```

---

## 🚀 Usage

### Initialize

```bash
cd tofu/environments/dev   # or prod
tofu init
```

### Plan

```bash
tofu plan
```

### Apply

```bash
tofu apply
```

### Destroy

```bash
tofu destroy
```

---

## 📄 License

Copyright (c) 2026 Thyamix

All rights reserved.

---
