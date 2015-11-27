FROM debian:wheezy
MAINTAINER Ali <ali@praqma.net>

# Install build dependencies

      RUN apt-get update -qq && \
      apt-get install -y -qq \
      build-essential \
      ca-certificates \
      curl \
      libcurl4-openssl-dev \
      libffi-dev \
      libgdbm-dev \
      libpq-dev \
      libreadline6-dev \
      libssl-dev \
      libtool \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      software-properties-common \
      wget \
      zlib1g-dev

# Install MRI Ruby 2.1.2  >>  http://ftp.ruby-lang.org/pub/ruby/

        RUN curl -O http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz && \
    tar -zxvf ruby-2.1.2.tar.gz && \
    cd ruby-2.1.2 && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-2.1.2 ruby-2.1.2.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc

# Clean up APT and temporary files when done
    RUN apt-get clean -qq && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install jekyll --no-ri --no-rdoc

WORKDIR /data
EXPOSE 4000

ENTRYPOINT ["jekyll"]
