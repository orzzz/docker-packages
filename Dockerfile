FROM zhanggangbz/docker_lamp_volume:latest
RUN rm -fr /app && git clone https://github.com/orzzz/LazyREST.git /app
EXPOSE 80 3306 22
CMD ["/run.sh"]
