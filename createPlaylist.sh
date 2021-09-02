#!/bin/sh

echo "[?] Creating list of .mp3" 

find /music/* -iname "*.mp3" > /playlists/playlist.txt

echo "[+] Done. List is at /playlists/playlist.txt" 
