rm -Rf build/lsteamclient.win64
rm -Rf build/lsteamclient.win32
rm -Rf build/steam.win32
rm -Rf dist

mkdir -p dist/lib64/wine/
mkdir -p dist/lib/wine/

# Build lsteamclient libs
export WINEMAKERFLAGS="--nosource-fix --nolower-include --nodlls --nomsvcrt --dll"
export CFLAGS="-O2 -g"
export CXXFLAGS="-Wno-attributes -O2 -g"

mkdir -p build/lsteamclient.win64
mkdir -p build/lsteamclient.win32

cp -a lsteamclient/* build/lsteamclient.win64
cp -a lsteamclient/* build/lsteamclient.win32

cd build/lsteamclient.win64
winemaker $WINEMAKERFLAGS -DSTEAM_API_EXPORTS .
make && strip lsteamclient.dll.so
cd ../..

cd build/lsteamclient.win32
winemaker $WINEMAKERFLAGS --wine32 -DSTEAM_API_EXPORTS .
make -e CC="winegcc -m32" CXX="wineg++ -m32" && strip lsteamclient.dll.so
cd ../..

cp -v build/lsteamclient.win64/lsteamclient.dll.so dist/lib64/wine/
cp -v build/lsteamclient.win32/lsteamclient.dll.so dist/lib/wine/

mkdir -p build/steam.win32
cp -a steam_helper/* build/steam.win32
cd build/steam.win32

export WINEMAKERFLAGS="--nosource-fix --nolower-include --nodlls --nomsvcrt --wine32"

winemaker $WINEMAKERFLAGS --guiexe -lsteam_api -I"../lsteamclient.win32/steamworks_sdk_142/" -L"../../steam_helper" .
make -e CC="winegcc -m32 -fpermissive" CXX="wineg++ -m32 -fpermissive" && strip steam.exe.so
cd ../..

cp -v build/steam.win32/steam.exe.so dist/lib/wine/
cp -v build/steam.win32/libsteam_api.so dist/lib/

ln -s -r dist/lib64/wine/lsteamclient.dll.so dist/steamclient64.dll.so
ln -s -r dist/lib/wine/lsteamclient.dll.so dist/steamclient.dll.so
ln -s -r dist/lib/wine/steam.exe.so dist/steam.exe.so
ln -s -r dist/lib/libsteam_api.so dist/libsteam_api.so
ln -s -r dist/lib/libsteam_api.so dist/steam_api.dll.so
