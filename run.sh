#!/bin/sh

echo "Iniciando servidor..."
python3 /app.py &


sleep 5


if [ -z "$VIDEO_URL" ] || [ -z "$RTMP_URL" ] || [ -z "$STREAM_KEY" ]; then
  echo "Erro: As variáveis de ambiente VIDEO_URL, RTMP_URL e STREAM_KEY devem ser definidas."
  exit 1
fi

echo "Iniciando FFmpeg..."


ffmpeg -re -stream_loop -1 \
-i "$VIDEO_URL" \
-c:v copy \
-c:a aac -ar 44100 -b:a 128k \
-f flv "$RTMP_URL/$STREAM_KEY"
