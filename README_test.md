## Setup system

project uses ruby version 2.4.2

* run next commands *
```
rake generator:schema:generate_all - generate schemas if not done yet

# run locally
eval $(make local)
make run_local

# deploy with docker
eval $(make test) - set env's
make build - build image
make deploy - deploy image

```

* and go to test.edoc-schema.kzn.ru *
