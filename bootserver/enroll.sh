#!/bin/bash

export NFS_SERVER_ADDR=`hostname -I | cut -d' ' -f1`
export NODE_SERIAL=$1
OUTPUT_DIR=outputs
export NFS_ROOT=/mnt/trunk/bootserver/nfs
export NFS_ID=`uuidgen`
export TFTP_ROOT=/mnt/trunk/bootserver/tftp

envsubst < templates/cmdline.txt > $OUTPUT_DIR/$NODE_SERIAL.node.cmdline.txt
envsubst < templates/fstab  > $OUTPUT_DIR/$NODE_SERIAL.node.fstab
envsubst < templates/hostname > $OUTPUT_DIR/$NODE_SERIAL.node.hostname
envsubst < templates/bootserver_fstab  > $OUTPUT_DIR/$NODE_SERIAL.bootserver.fstab
envsubst < templates/bootserver_exports > $OUTPUT_DIR/$NODE_SERIAL.bootserver.exports

# make sure dirs exists on bootserver
mkdir -p $TFTP_ROOT/$NODE_SERIAL
mkdir -p $TFTP_ROOT/$NODE_SERIAL-upper
mkdir -p $TFTP_ROOT/$NODE_SERIAL-work
# cat $OUTPUT_DIR/$NODE_SERIAL.node.cmdline.txt > $TFTP_ROOT/$NODE_SERIAL-upper/cmdline.txt

mkdir -p $NFS_ROOT/$NODE_SERIAL
mkdir -p $NFS_ROOT/$NODE_SERIAL-upper/etc
mkdir -p $NFS_ROOT/$NODE_SERIAL-work
# cat $OUTPUT_DIR/$NODE_SERIAL.node.fstab > $NFS_ROOT/$NODE_SERIAL-upper/etc/fstab
# cat $OUTPUT_DIR/$NODE_SERIAL.node.hostname > $NFS_ROOT/$NODE_SERIAL-upper/etc/hostname

# require manual changes on bootserver
TEMPFILE=$(mktemp /tmp/pi_enroll.XXXXXX)
# umount if already mounted
umount $TFTP_ROOT/$NODE_SERIAL
umount $NFS_ROOT/$NODE_SERIAL
grep -v $NODE_SERIAL /etc/fstab > $TEMPFILE
cat $OUTPUT_DIR/$NODE_SERIAL.bootserver.fstab >> $TEMPFILE
cp $TEMPFILE /etc/fstab
mount $TFTP_ROOT/$NODE_SERIAL
mount $NFS_ROOT/$NODE_SERIAL
cat $OUTPUT_DIR/$NODE_SERIAL.node.cmdline.txt > $TFTP_ROOT/$NODE_SERIAL/cmdline.txt
cat $OUTPUT_DIR/$NODE_SERIAL.node.fstab > $NFS_ROOT/$NODE_SERIAL/etc/fstab
cat $OUTPUT_DIR/$NODE_SERIAL.node.hostname > $NFS_ROOT/$NODE_SERIAL/etc/hostname

grep -v $NODE_SERIAL /etc/exports > $TEMPFILE
cat $OUTPUT_DIR/$NODE_SERIAL.bootserver.exports >> $TEMPFILE
cp $TEMPFILE /etc/exports
exportfs -ra
