#!/bin/sh

# Inicia o servidor web falso EM SEGUNDO PLANO
echo 
python3 /app.py &

# Dá um tempo para o servidor web iniciar
sleep 5

# Verifica se as variáveis de ambiente essenciais foram definidas
# Note que agora temos IMAGE_URL e AUDIO_URL em vez de VIDEO_URL
if [ -z "$IMAGE_URL" ] || [ -z "$AUDIO_URL" ] || [ -z "$RTMP_URL" ] || [ -z "$STREAM_KEY" ]; then
  echo "Erro: As variáveis IMAGE_URL, AUDIO_URL, RTMP_URL e STREAM_KEY devem ser definidas."
  exit 1
fi

echo 

# --- O NOVO COMANDO MÁGICO DO FFMPEG ---
ffmpeg \
    -loop 1 -r 2 -i "$IMAGE_URL" \
    -stream_loop -1 -re -i "$AUDIO_URL" \
    -c:v libx264 -preset veryfast -tune stillimage -pix_fmt yuv420p \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv "$RTMP_URL/$STREAM_KEY"
