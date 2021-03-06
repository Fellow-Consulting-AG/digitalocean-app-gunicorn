FROM python:3.8

LABEL maintainer="Daniel Jordan <daniel.jordan@fellow-consulting.de>"

#RUN pip install meinheld Gunicorn
RUN pip install  Gunicorn

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY ./start.sh /start.sh
RUN chmod +x /start.sh


COPY ./gunicorn_conf.py /gunicorn_conf.py


COPY requirements.txt /

RUN pip install -r /requirements.txt



COPY ./app /app
RUN chmod +x /app/prestart.sh
WORKDIR /app/

ENV PYTHONPATH=/app

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

# Run the start script, it will check for an /app/prestart.sh script (e.g. for migrations)
# And then will start Gunicorn with Meinheld
CMD ["/start.sh"]