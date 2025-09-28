# github pages repo

This repo contains the content for my github pages. [calhuskerfan](https://calhuskerfan.github.io/)

I use devcontainers to author and verify my posts, it is a much cleaner solution for me, considering my primary technologies, than trying to manage as part of my everyday toolkit.  The following are the steps I took to set up and use devcontainers.

## Devcontainers

Environment:
1. Windows 11
1. Docker Desktop
1. Visual Studio Code
1. vs-code devcontainers plugin

## Setup:

1. started repo
    1. initial docs
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

### Themes

Currently using Minima

[gem based themes](https://jekyllrb.com/docs/themes/#understanding-gem-based-themes)

### plugins

### References

1. kramdown kramdown is the default Jekyll Markdown processor.
    - [kramdown cheat sheet](https://dieghernan.github.io/chulapa-101/cheatsheets/02-kramdown-cheat-sheet)


### Examples
[peterroelants](https://peterroelants.github.io/)
