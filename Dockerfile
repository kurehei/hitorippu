FROM ruby:2.6.0-alpine
ENV APP_ROOT /hitorippu

RUN gem install bundler
WORKDIR $APP_ROOT

RUN apk update && \
  apk add --no-cache \
  bash \
  postgresql-dev \
  build-base \
  nodejs \
  tzdata \
  curl-dev \
  linux-headers \
  libxml2-dev \
  libxslt-dev \
  mysql-dev \
  mysql-client \
  pkgconfig \
  imagemagick6 \
  imagemagick6-c++ \
  imagemagick6-dev \
  imagemagick6-libs \
  gmp-dev 

COPY .bundle ./
COPY Gemfile Gemfile.lock ./

RUN gem install rmagick
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
COPY . ./
