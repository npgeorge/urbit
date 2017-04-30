source $setup

tar -xf $src
mv pololu-usb-avr-programmer-v2-* pavr2

cd pavr2
for patch in $patches; do
  echo applying patch $patch
  patch -p1 -i $patch
done
cd ..

mkdir build
cd build

PKG_CONFIG=$PKG_CONFIG_CROSS \
cmake ../pavr2 \
  -DCMAKE_TOOLCHAIN_FILE=$cmake_toolchain \
  -DCMAKE_INSTALL_PREFIX=$out

make

make install
