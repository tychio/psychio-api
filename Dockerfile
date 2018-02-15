FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /api
WORKDIR /api
ADD Gemfile /api/Gemfile
ADD Gemfile.lock /api/Gemfile.lock
RUN bundle install
ADD . /api

RUN apt-get update && apt-get install -y python-pip && \
	pip install -U cos-python-sdk-v5