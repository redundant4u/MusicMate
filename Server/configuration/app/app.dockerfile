FROM python:3.6

ENV PYTHONUNBUFFERED=1

RUN useradd -u 1001 -m redundant

RUN apt-get update
RUN apt-get install -y \
    vim

WORKDIR /home/redundant/django
COPY requirements.txt .
RUN pip install -r requirements.txt

# RUN django-admin startproject MusicMate .

COPY bashrc /home/redundant/.bashrc

USER redundant

# COPY uwsgi.ini .
CMD [ "uwsgi", "--ini", "uwsgi.ini" ]
