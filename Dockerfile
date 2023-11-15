# pull official base image
FROM python:3.11.4-slim-buster

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN useradd --system ${USER} && \
    chown --recursive ${USER} ${WORKDIR}

# install dependencies
# RUN pip install --upgrade pip
RUN apt update && apt upgrade -y

# COPY ./requirements.txt .
# RUN pip install -r requirements.txt

COPY --chown=${USER} requirements.txt requirements.txt
COPY --chown=${USER} requirements requirements

RUN pip install --upgrade pip && \
    pip install --requirement requirements/production.txt

# copy project
# COPY . .
COPY --chown=${USER} ./Makefile Makefile
COPY --chown=${USER} ./manage.py manage.py
COPY --chown=${USER} ./core core
COPY --chown=${USER} ./apps apps

USER ${USER}

EXPOSE 8000