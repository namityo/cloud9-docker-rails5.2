FROM ruby:2.5

ENV LANG C.UTF-8
ENV WORKSPACE=/usr/local/src

# install bundler.
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    less \
    libpq-dev \
    nodejs \
    vim && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

# create user and group.
RUN groupadd -r --gid 501 rails && \
    useradd -m -r --uid 501 --gid 501 rails

# create directory.
RUN mkdir -p $WORKSPACE $BUNDLE_APP_CONFIG && \
    chown -R rails:rails $WORKSPACE && \
    chown -R rails:rails $BUNDLE_APP_CONFIG

USER rails
WORKDIR $WORKSPACE

RUN gem install bundler

# install ruby on rails.
ADD --chown=rails:rails src $WORKSPACE
#RUN bundle install