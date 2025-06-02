# Hub-and-Spoke Architecture on Azure using Terraform

This repository implements a **Hub-and-Spoke** network architecture on Microsoft Azure using **Terraform**. The goal of the project is to provide a modular, secure, and scalable cloud infrastructure.

---


###  `firewall.tf`
- Deploys an `azurerm_firewall` resource in the Hub network.
- Defines NAT and network rules.
- Provides centralized traffic filtering and control across spoke networks.

###  `nsg.tf`
- Creates `azurerm_network_security_group`.
- Configures security rules for subnets or virtual machines.

###  `peerings.tf`
- Establishes VNet peering between the Hub and Spoke networks.
- Enables private network traffic between them.

###  `route_table.tf`
- Creates route tables and associates them with subnets.
- Allows routing through the Hub (e.g., via firewall).

###  `main.tf`
- Integrates all infrastructure resources: networks, peerings, VMs, NSGs, and more.

###  `providers.tf`
- Configures the Terraform provider for Azure.
- Enables access to your Azure subscription.

###  `outputs.tf`
- Exposes useful output values like IP addresses and resource IDs.

##  Module: `vm` — Virtual Machines

The `vm` module is used to provision virtual machines within spoke subnets. It allows you to define operating systems, instance sizes, and administrator credentials easily.

- Creates a VM in a specified subnet.
- Attaches a Network Interface (NIC).
- Sets up administrator credentials.
- Optionally assigns a public IP address.

