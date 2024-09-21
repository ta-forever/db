FROM flyway/flyway:10.18-alpine

ENV FLYWAY_EDITION community

COPY migrations /flyway/sql/
