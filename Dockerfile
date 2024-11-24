FROM amazonlinux:latest

# Instalar dependências
RUN yum update -y && \
    yum install -y httpd wget unzip

# Descarregar o ficheiro .zip
RUN wget https://github.com/edgarjose/deploy-static-website-on-aws/archive/refs/heads/main.zip -O /tmp/main.zip

# Descompactar o ficheiro descarregado
RUN unzip /tmp/main.zip -d /tmp/

# Copiar os ficheiros necessários para o diretório html
RUN cp -r /tmp/deploy-static-website-on-aws-main/festava_live/* /var/www/html/

# Limpar removendo o ficheiro zip e a pasta temporária
RUN rm -rf /tmp/deploy-static-website-on-aws-main /tmp/main.zip

# Expor a porta 80
EXPOSE 80

# Iniciar o servidor Apache em primeiro plano
ENTRYPOINT [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]
