FROM ruby:3.4

# System dependencies
RUN apt-get update -qq \
 && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
    default-libmysqlclient-dev \
    git \
 && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

WORKDIR /app

# Match Bundler and Rails versions from README
RUN gem install bundler -v 2.6.2 -N \
 && gem install rails -v 8.0.2 -N

# Default command is set via docker-compose

