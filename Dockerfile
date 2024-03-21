FROM ruby:3.0.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm default-mysql-client
RUN npm install -g yarn

RUN mkdir /myapp
WORKDIR /myapp

ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
