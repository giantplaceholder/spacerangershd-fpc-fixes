@echo off
cd /d "%~dp0"
git clone https://github.com/pakompom/SpaceRangersHD_FPC.git
cd SpaceRangersHD_FPC
git checkout --detach 5f491a841cbd11d2a9a6861a822a08ffa64d15f2
git submodule update --init --recursive
git -C vendor/fpc checkout --detach 3a1c9cfae7f7a2bb17079b2989f562dbc5728b01
git -C vendor/okgf checkout --detach c01aa7a168a6f1772541501074b7bba1b96550ef
for %%p in (..\*.patch) do git apply "%%p"
cd ..