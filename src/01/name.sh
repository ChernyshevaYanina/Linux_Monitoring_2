#!/bin/bash
function make_name () {
    letter=""
    in=${1}
    len=${#1}
    g=$(bc<<<$RANDOM%$len)
    letter+=${in:0:$g};
    letter+=${in:$g:1};
    letter+=${in:$g:$len};
}