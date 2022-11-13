FROM ruby:2.7.1

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock ./
ADD . /Rails-Docker
WORKDIR /Rails-Docker
RUN bundle install

EXPOSE 3000

CMD ["bash"]