# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t app .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name app app

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.5
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

ENV LANGUAGE=ja_JP:ja_JP
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
# 複数のGemを並列にコンパイルする
ENV BUNDLE_JOBS=4
ENV BUNDLE_RETRY=3
# 記述されてるGemはすべてインストールする
ENV BUNDLE_WITHOUT=""
ENV BUNDLE_PATH=/bundle

WORKDIR /app

# Install base packages (include build tools for dev 'bundle install')
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      curl \
      default-mysql-client \
      libjemalloc2 \
      libvips \
      build-essential \
      default-libmysqlclient-dev \
      git \
      libyaml-dev \
      pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p db log storage tmp && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

EXPOSE 3000
