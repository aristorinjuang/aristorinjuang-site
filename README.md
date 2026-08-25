# aristorinjuang.com — Static Site Output

The pre-built static site for
[aristorinjuang.com](https://aristorinjuang.com), generated with
[Lesstruct](https://lesstruct.dev) (a Go CMS/SSG engine) and committed
as-is so [AWS Amplify](https://aws.amazon.com/amplify/) can serve it
directly with no build step.

This repo is intentionally public, like its
[source](https://github.com/aristorinjuang/aristorinjuang) — everything
here is already publicly served on the live site.

## Repo layout

    _build/                         Generated site — Amplify artifact root.
                                    Do not edit by hand; it is regenerated
                                    by deploy.sh
    amplify.yml                     Amplify config (serves _build/ verbatim)
    deploy.sh                       Regenerates _build/, commits, and pushes

## How deploys work

`deploy.sh` pulls a fresh build from a running Lesstruct server, then
commits and pushes; Amplify picks up the push and redeploys:

    LESSTRUCT_BASE_URL=http://localhost:8080
    LESSTRUCT_API_KEY=...
    ./deploy.sh

Requirements: `lesstruct-cli` installed, `curl`, a reachable Lesstruct
server, and `LESSTRUCT_API_KEY` set in the environment.

## Source

The theme and site configuration live in
[aristorinjuang/aristorinjuang](https://github.com/aristorinjuang/aristorinjuang).

## License

© Aristo Rinjuang. All rights reserved.

This repository is published for inspiration and education — you're
welcome to read and learn from how the site is put together, but the
content is not licensed for reuse or redistribution.
