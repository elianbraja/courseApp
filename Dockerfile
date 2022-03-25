FROM ruby:2.7.1-alpine

RUN apk add --update --virtual \
    runtime-deps \
    postgresql-client \
    postgresql-dev \
    build-base \
    libxml2-dev \
    libxslt-dev \
    nodejs \
    yarn \
    libffi-dev \
    readline \
    libc-dev \
    readline-dev \
    linux-headers \
    file \
    git \
    tzdata \
    && rm -rf /var/cache/apk/* \

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

ADD . /app

