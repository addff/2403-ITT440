#!/usr/local/bin/bash
#!/usr/bin/bash
#!/bin/bash

timestamp=$(TZ=Asia/Kuala_Lumpur date)

mkdir 2403-ITT440_Final_Assessment/

# Meminta input dari pengguna
read -p "Enter Your Shortname (one word only): " nama_singkatan
read -p "Enter Your Full Name (CAPITAL LETTER): " nama
read -p "Enter Your Student ID: " nombor_pelajar


cd 2403-ITT440_Final_Assessment/
folder_name="${nama_singkatan}_q1"
mkdir "$folder_name"
cd "$folder_name"

# Menulis maklumat ke dalam fail q1.sh
echo "# Name: $nama" > "2403-ITT440_${nama_singkatan}_q1.sh"
echo "# Student ID: $nombor_pelajar" >> "2403-ITT440_${nama_singkatan}_q1.sh"
echo "# Shortname: $nama_singkatan" >> "2403-ITT440_${nama_singkatan}_q1.sh"
echo "# Date: $timestamp" >> "2403-ITT440_${nama_singkatan}_q1.sh"


# Memaklumkan pengguna bahawa maklumat telah disimpan
echo "Maklumat telah disimpan dalam fail 2403-ITT440_${nama_singkatan}_q1.sh"


cd ..
folder_name="${nama_singkatan}_q2"
mkdir "$folder_name"
cd "$folder_name"

# Menulis maklumat ke dalam fail q2_server.c
echo "// Name: $nama" > "2403-ITT440_${nama_singkatan}_q2_server.c"
echo "// Student ID: $nombor_pelajar" >> "2403-ITT440_${nama_singkatan}_q2_server.c"
echo "// Shortname: $nama_singkatan" >> "2403-ITT440_${nama_singkatan}_q2_server.c"
echo "// Date: $timestamp" >> "2403-ITT440_${nama_singkatan}_q2_server.c"

# Menulis maklumat ke dalam fail q2_client.c
echo "// Name: $nama" > "2403-ITT440_${nama_singkatan}_q2_client.c"
echo "// Student ID: $nombor_pelajar" >> "2403-ITT440_${nama_singkatan}_q2_client.c"
echo "// Shortname: $nama_singkatan" >> "2403-ITT440_${nama_singkatan}_q2_client.c"
echo "// Date: $timestamp" >> "2403-ITT440_${nama_singkatan}_q2_client.c"

# Memaklumkan pengguna bahawa maklumat telah disimpan
echo "Maklumat telah disimpan dalam fail 2403-ITT440_${nama_singkatan}_q2_server.c"
echo "Maklumat telah disimpan dalam fail 2403-ITT440_${nama_singkatan}_q2_client.c"

cd ..
folder_name="${nama_singkatan}_q3"
mkdir "$folder_name"
cd "$folder_name"

# Menulis maklumat ke dalam fail q3_server.py
echo "# Name: $nama" > "2403-ITT440_${nama_singkatan}_q3_server.py"
echo "# Student ID: $nombor_pelajar" >> "2403-ITT440_${nama_singkatan}_q3_server.py"
echo "# Shortname: $nama_singkatan" >> "2403-ITT440_${nama_singkatan}_q3_server.py"
echo "# Date: $timestamp" >> "2403-ITT440_${nama_singkatan}_q3_server.py"

# Menulis maklumat ke dalam fail q3_client.py
echo "# Name: $nama" > "2403-ITT440_${nama_singkatan}_q3_client.py"
echo "# Student ID: $nombor_pelajar" >> "2403-ITT440_${nama_singkatan}_q3_client.py"
echo "# Shortname: $nama_singkatan" >> "2403-ITT440_${nama_singkatan}_q3_client.py"
echo "# Date: $timestamp" >> "2403-ITT440_${nama_singkatan}_q3_client.py"

# Memaklumkan pengguna bahawa maklumat telah disimpan
echo "Maklumat telah disimpan dalam fail 2403-ITT440_${nama_singkatan}_q3_server.py"
echo "Maklumat telah disimpan dalam fail 2403-ITT440_${nama_singkatan}_q3_client.py"

cd ..
folder_name="${nama_singkatan}_q4"
mkdir "$folder_name"
cd "$folder_name"

# Menulis maklumat ke dalam fail q4.py
echo "# Name: $nama" > "2403-ITT440_${nama_singkatan}_q4.py"
echo "# Student ID: $nombor_pelajar" >> "2403-ITT440_${nama_singkatan}_q4.py"
echo "# Shortname: $nama_singkatan" >> "2403-ITT440_${nama_singkatan}_q4.py"
echo "# Date: $timestamp" >> "2403-ITT440_${nama_singkatan}_q4.py"

# Memaklumkan pengguna bahawa maklumat telah disimpan
echo "Maklumat telah disimpan dalam fail 2403-ITT440_${nama_singkatan}_q4.py"

cd ../..
tree 2403-ITT440_Final_Assessment
