FROM ruby:3.3

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 9292

CMD ["ruby", "app.rb"]