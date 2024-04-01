#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=porsche
export DEVICE_COMMON=sm8350-common
export VENDOR=realme
export VENDOR_COMMON=oneplus

"./../../${VENDOR_COMMON}/${DEVICE_COMMON}/extract-files.sh" "$@"

function split_image() {
    local radio_path="../../../vendor/${VENDOR}/${DEVICE}/radio"
    echo "$radio_path"/"$1"

    if [ -z "$radio_path"/"$1" ] || [ ! -f "$radio_path"/"$1" ]; then
        echo "Error: "
        return 1
    fi

    split --bytes=20M -d "$radio_path"/"$1" "$radio_path/$(basename "$1").part"

    echo "  + Splitted $1"
}

split_image modem.img
