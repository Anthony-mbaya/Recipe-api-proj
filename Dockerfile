FROM python:3.9-alpine3.13
#python - image, alpine - tagname
LABEL maintainer="CruxTon"
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tnp/requirements.txt
COPY ./requirements.dev.txt /tnp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

#copy the req file, app to the docker file ,expose port 8000 - dj

ARG DEV=false
#defines a build argument called dev

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client jpeg-dev && \
    apk add --update --no-cache --virtual .tnp-build-deps \
        build-base postgresql-dev musl-dev zlib zlib-dev && \
    /py/bin/pip install -r /tnp/requirements.txt && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tnp/requirements.dev.txt ; \
    fi && \
    rm -rf /tnp && \
    apk del .tnp-build-deps && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

# 13 - creates new venv - store dependencies
# 14 - install and upgrade pip
# 15 - install req from req file
# 16 - remove tnp dir - make image lightweight
# 17 - adduser - customize user  - manipulate docker file


ENV PATH="/py/bin:$PATH"

USER django-user