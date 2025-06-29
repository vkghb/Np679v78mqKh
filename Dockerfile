# Usar uma imagem base leve do Ubuntu
FROM ubuntu:22.04

# Configuração para evitar que a instalação peça confirmação
ENV DEBIAN_FRONTEND=noninteractive

# Instala o FFmpeg, Python e Flask
RUN apt-get update && apt-get install -y ffmpeg python3 python3-pip && \
    pip3 install Flask && \
    rm -rf /var/lib/apt/lists/*

# Copia AMBOS os scripts para dentro da imagem
COPY app.py /app.py
COPY run.sh /run.sh

# Dá permissão de execução para o script principal
RUN chmod +x /run.sh

# Comando final que será executado quando o serviço iniciar
CMD ["/run.sh"]
