# github pages repo

This repo contains the content for my github pages. [calhuskerfan](https://calhuskerfan.github.io/)

I am using [devcontainers](https://code.visualstudio.com/docs/devcontainers/containers) to author and and verify jekyll output before committing.

## Devcontainers

Environment:
1. Windows 11
1. Docker Desktop
1. Visual Studio Code
1. vs-code devcontainers plugin

## Setup

This setup assumes your repo has a /docs folder containing a valid jeckyll site compatabile with [github pages](https://docs.github.com/en/pages).

1. added and configured ./devcontainer/devcontainer.json.  [Tutorial](https://code.visualstudio.com/docs/devcontainers/tutorial).
1. in visual studio code open the repo in the devcontainer
1. some sanity checks
    ```bash
    ruby -v
    jekyll -v
    gem -v
    ```
1. cd to /docs
1. bundle install

## Usage

1. cd to /docs
1. bundle exec jekyll serve --livereload --drafts

## Jekyll References

The following sections are some notes on what I am using for my jekyll site and some of my favorite references.

### Themes

Currently using Minima

[gem based themes](https://jekyllrb.com/docs/themes/#understanding-gem-based-themes)

### plugins

### References

1. kramdown kramdown is the default Jekyll Markdown processor.
    - [kramdown cheat sheet](https://dieghernan.github.io/chulapa-101/cheatsheets/02-kramdown-cheat-sheet)


### Examples

[peterroelants](https://peterroelants.github.io/)
