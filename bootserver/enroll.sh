#!/bin/bash

export NFS_SERVER_ADDR=`hostname -I | cut -d' ' -f1`
export NODE_SERIAL=$1
OUTPUT_DIR=outputs

envsubst < templates/cmdline.txt > $OUTPUT_DIR/$NODE_SERIAL.node.cmdline.txt
envsubst < templates/fstab  > $OUTPUT_DIR/$NODE_SERIAL.node.fstab
envsubst < templates/bootserver_fstab  > $OUTPUT_DIR/$NODE_SERIAL.bootserver.fstab
envsubst < templates/bootserver_exports > $OUTPUT_DIR/$NODE_SERIAL.bootserver.exports
