#!/bin/bash

identify_system_type() {
    if [ -d '/sys/firmware/efi' ]; then
        system_type=uefi
    else
        system_type=bios
    fi

    export system_type
}

prepare_uefi() {
  # some validations
    [ -n "${system_type}" ] || exit 1
    [ "${system_type}" = "uefi" ] || exit 1
  # clear the disk
    /sbin/sgdisk -Z /dev/sda
  # set partitions
    /sbin/sgdisk --new=1:0:+128M --new=2:0:0 /dev/sda
  # set partition types
    /sbin/sgdisk --typecode=1:ef00 --typecode=2:8300 /dev/sda
  # create boot fs
    /sbin/mkfs.vfat -n bootfs /dev/sda1
  # create root fs
    /sbin/mkfs.ext4 -F -L rootfs /dev/sda2
}

prepare_bios() {
  # some validations
    [ -n "${system_type}" ] || exit 1
    [ "${system_type}" = "bios" ] || exit 1
  # clear the disk
    /sbin/sgdisk -Z /dev/sda
  # set partitions
    /sbin/sgdisk --new=1:0:+128M --new=2:0:0 /dev/sda
  # set partition types
    /sbin/sgdisk --typecode=1:8300 --typecode=2:8300 /dev/sda
  # mark boot partition
    /sbin/sgdisk --attributes=1:set:2 /dev/sda
  # create boot fs
    /sbin/mkfs.ext4 -F -L bootfs /dev/sda1
  # create root fs
    /sbin/mkfs.ext4 -F -L rootfs /dev/sda2
  # install bootloader
    /bin/dd bs=440 count=1 if=/netboot/syslinux_bios/gptmbr.bin of=/dev/sda
  # install syslinux (extlinux)
    /bin/mount -t ext4 -o noatime,rw /dev/sda1 /boot
    /bin/tar -x -z -C /boot -f /netboot/syslinux_bios/syslinux.tar.gz
    /sbin/extlinux --install /boot/syslinux
    /bin/umount /boot
}

### EXECUTE

identify_system_type
prepare_${system_type}
