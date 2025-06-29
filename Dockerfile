# Usar uma imagem base leve do sistema operacional Ubuntu
FROM ubuntu:22.04

# Configuração para evitar que a instalação peça confirmação
ENV DEBIAN_FRONTEND=noninteractive

# Instala o FFmpeg e limpa o cache para manter o tamanho final pequeno
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# Copia o nosso script de execução para dentro da imagem
COPY run.sh /run.sh

# Dá permissão de execução para o script
RUN chmod +x /run.sh

# Comando final que será executado quando o serviço iniciar
CMD ["/run.sh"]
