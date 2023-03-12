# Boot Server Requirements
---

## Stage 1

Basic setup

- Ability to boot BIOS and UEFI systems
- Automated configuration of clean nodes to a working state including:
    - partitioning of hard drive
    - installation of base os (Gentoo, Devuan)


## Stage 2

Advanced setup

- Creation of a HTTP API with the following functionality
    - nodes CRUD endpoint to register systems with MAC address
    - roles CRUD endpoint to register roles with ansible role location (URI)
    - mapping endpoint to associate roles to nodes

- Define security features for kernels and init fs


## Stage 3

Extended features

- Replace TFTP server with custom implementation which plugs in to the API
  - TFTP to adjust response based on whether the node is registered and its assigned configuration

- Add support for UEFI HTTP boot

- Implement security features for kernel and init fs

