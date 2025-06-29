#!/bin/sh

# Verifica se as variáveis de ambiente essenciais foram definidas
if [ -z "$VIDEO_URL" ] || [ -z "$RTMP_URL" ] || [ -z "$STREAM_KEY" ]; then
  echo "Erro: As variáveis de ambiente VIDEO_URL, RTMP_URL e STREAM_KEY devem ser definidas."
  exit 1
fi

echo "-> Iniciando a transmissão para o servidor RTMP..."
echo "-> Fonte do vídeo: $VIDEO_URL"

# Comando do FFmpeg que roda em loop infinito
ffmpeg -re -stream_loop -1 \
-i "$VIDEO_URL" \
-c:v copy \
-c:a aac -ar 44100 -b:a 128k \
-f flv "$RTMP_URL/$STREAM_KEY"
