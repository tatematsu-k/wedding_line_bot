FROM ruby:3.1.1-slim

RUN apt-get update -qq \
	  && apt-get install -y sudo \
                            curl \
                            git \
                            build-essential \
                            default-libmysqlclient-dev \
                            shared-mime-info && \
    gem install bundler -v '2.3.7'

RUN mkdir /wedding_line_bot
WORKDIR /wedding_line_bot
COPY Gemfile /wedding_line_bot/Gemfile
COPY Gemfile.lock /wedding_line_bot/Gemfile.lock
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install
COPY . /wedding_line_bot

# copilot の pipeline でサービスデプロイ前にフックする方法がないので entrypoint.sh で実行
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 80
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "80"]
