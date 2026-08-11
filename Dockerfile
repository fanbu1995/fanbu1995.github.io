FROM ruby:3.3.12-slim

ARG BUNDLER_VERSION=4.0.16

RUN apt-get update \
    && apt-get install --yes --no-install-recommends build-essential git \
    && rm -rf /var/lib/apt/lists/* \
    && gem install bundler --version "${BUNDLER_VERSION}"

WORKDIR /site

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]
