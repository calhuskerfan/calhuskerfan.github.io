# github pages repo

This repo contains the content for my github pages. [calhuskerfan](https://calhuskerfan.github.io/)

## Devcontainers

Local development with devcontainers is a very efficient way to develop locally.

Environment:
1. Windows 11
1. Docker Desktop
1. Visual Studio Code
1. vs-code devcontainers plugin

Setup:

1. added ./devcontainer/devcontainer.json
1. open in devcontainer
1. some sanity checks
    ```bash
    ruby -v
    jekyll -v
    gem -v
    ```
1. cd to /docs
1. bundle install
1. bundle exec jekyll serve --livereload

### References
[peterroelants](https://peterroelants.github.io/)
