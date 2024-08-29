FROM ruby:latest

RUN apt-get update -qq && apt-get install -y nodejs npm

RUN gem install jekyll bundler

WORKDIR /usr/src/app

#COPY site/ /usr/src/app #Causes site content to be cached, making updates more difficult
COPY site/Gemfile site/Gemfile.lock ./

RUN bundle install

COPY . ./

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]

#Useful commands
#docker build -t jekyll_local .
#docker run -it --rm -v "${PWD}/site:/usr/src/app" -p 4000:4000 jekyll_local:latest