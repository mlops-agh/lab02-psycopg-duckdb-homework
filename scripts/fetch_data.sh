#!/usr/bin/env bash
# Download Rijdende Treinen open data into ../data and unpack .gz files.

set -e

BASE_URL="https://opendata.rijdendetreinen.nl/public"
DATA_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../data"

mkdir -p "$DATA_DIR"
cd "$DATA_DIR"

# Single files
curl -fLO "$BASE_URL/tariff-distances/tariff-distances-2022-01.csv"
curl -fLO "$BASE_URL/stations/stations-2023-09.csv"

# Disruptions: yearly files 2011..2023
for year in $(seq 2011 2023); do
    curl -fLO "$BASE_URL/disruptions/disruptions-$year.csv"
done

# Services: yearly gzipped files 2019..2025 (unpacked, .gz kept)
for year in $(seq 2019 2025); do
    curl -fLO "$BASE_URL/services/services-$year.csv.gz"
    gunzip -f "services-$year.csv.gz"
done