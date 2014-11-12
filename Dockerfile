FROM google/nodejs:0.10.32

WORKDIR /app
ADD package.json /app/
RUN npm install
ADD . /app

ENV PORT 8080
EXPOSE 8080

CMD []
ENTRYPOINT ["/nodejs/bin/node", "index.js"]
