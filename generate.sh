#!/bin/bash
release_json=$(curl https://api.github.com/repos/xivdev/Penumbra/releases/latest)

count=$(echo "$release_json" | jq '.assets[0].download_count')
download=$(echo "$release_json" | jq '.assets[0].browser_download_url')
time=$(echo "$release_json" | jq -r '.published_at')
time=$(date -d "$time" +'%s')
version=$(echo "$release_json" | jq '.tag_name')
config=$(curl "https://raw.githubusercontent.com/xivdev/Penumbra/master/Penumbra/Penumbra.json")

config=$(echo "$config" | jq '. += {"IsHide": false}')
config=$(echo "$config" | jq '. += {"IsTestingExclusive": false}')
config=$(echo "$config" | jq '. += {"LastUpdated": '$time'}')
config=$(echo "$config" | jq '. += {"DownloadCount": '$count'}')
config=$(echo "$config" | jq '. += {"DownloadLinkInstall": '$download'}')
config=$(echo "$config" | jq '. += {"DownloadLinkTesting": '$download'}')
config=$(echo "$config" | jq '. += {"DownloadLinkUpdate": '$download'}')
config=$(echo "$config" | jq '. += {"AssemblyVersion": '$version'}')
#config=$(echo "$config" | jq '. += {"": '$'}')

echo "[$config]" > main.json
