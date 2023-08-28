#!/bin/bash

function start_testcontainer() {
    docker run --name testcontainer \
            --mount "type=bind,source=./../lib,target=/mnt" \
            -d \
            --rm \
            ubuntu:latest \
            tail -f /dev/null    
}

function test_apt_clear_package_index() {
    local lines
    {
        start_testcontainer
        docker exec testcontainer apt-get update
        docker exec testcontainer bash -c "find /var/lib/apt/lists | wc -l"
        docker exec testcontainer bash -c "source /mnt/apt.sh && apt_clear_package_index"
        docker exec testcontainer bash -c "find /var/lib/apt/lists"
        lines=$(docker exec testcontainer bash -c "find /var/lib/apt/lists | wc -l")
    }
    docker stop testcontainer

    assertEquals 1 "$lines"
}

function test_apt_check_packages_installed() {
    local exit_code_before_install
    local exit_code_after_install
    {
        start_testcontainer
        exit_code_before_install=$(docker exec testcontainer bash -c 'source /mnt/apt.sh && apt_check_packages_installed unzip; echo $?')
        docker exec testcontainer bash -c "apt-get update && apt-get install unzip --yes"
        exit_code_after_install=$(docker exec testcontainer bash -c 'source /mnt/apt.sh && apt_check_packages_installed unzip; echo $?')
    }
    docker stop testcontainer

    assertNotEquals 0 "$exit_code_before_install"
    assertEquals 0 "$exit_code_after_install"
}

function test_apt_update_index_if_empty() {
    {
        start_testcontainer
        docker exec testcontainer bash -c 'source /mnt/apt.sh; apt_update_index_if_empty'
        echo "Retrying"
        docker exec testcontainer bash -c 'source /mnt/apt.sh; apt_update_index_if_empty'
        echo "Done"
    }
    docker stop testcontainer
}


source shunit2