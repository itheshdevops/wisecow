FROM ubuntu:latest
RUN apt update && apt install fortune-mod cowsay -y
WORKDIR /app

COPY . .
RUN chmod 777 wisecow.sh
EXPOSE 4499
CMD ["./wisecow.sh"]
