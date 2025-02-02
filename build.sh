64tass  --no-warn --map "main.map" --output-exec=start --c256-pgz "./src/main.asm" --m65816  --list="app.lst" -Wno-portable -o "app.pgz"
export FOENIXMGR='/mnt/d/Retro/Foenix/Repos/FoenixMgr'
sudo chmod 666 /dev/ttyUSB0
python $FOENIXMGR/FoenixMgr/fnxmgr.py --copy app.pgz