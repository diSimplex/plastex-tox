# PlasTeX Tox

A [Podman](https://docs.podman.io/en/latest/) environment in which to run
[Tox](https://tox.wiki/en/latest/) on the [diSimplex
fork](https://github.com/diSimplex/plastex) of
[PlasTeX](https://github.com/plastex/plastex).

## Scripts

Besides the `Dockerfile` itself, we provide a collection of scripts
designed to automate the build, running and removal of these PlasTeX Tox
images.

All of these scripts are meant to be run *in* the `plastex-tox` root
directory.

1. `./scripts/build` uses the supplied `Dockerfile` to build the
   `plastex-tox-testeri` image.

2. `./scripts/run` uses the `plastex-tox-testeri` image to run as a simple
   command line environment (using `/bin/bash`) sufficient to run `tox`.

   This script requires *one* command line argument, the location of the
   plastex code which needs to be tested.

   This running container will *stop* when the `/bin/bash` instance is
   exited.

3. `./scripts/enter` re-enters a running `plastex-tox-testerc` container
   (created by the `./scripts/run` script) to provide another command line
   environment (using `/bin/bash`).

4. `./scripts/restart` re-starts a stopped `plastex-tox-testerc`
   container and provides a command line environment (using `/bin/bash`).

5. `./scripts/cleanupContainer` removes any existing `plastex-tox-testerc`
   container.

6. `./scripts/cleanupImage` removes any existing `plastex-tox-testeri`
   image.

These scripts *explicitly* require the [Podman](https://podman.io/) tools
run
[rootlessly](https://developers.redhat.com/blog/2020/09/25/rootless-containers-with-podman-the-basics).

In particular, in rootless mode, the `root` user inside a Podman container
maps to the user running the Podman container on the host-machine. This
makes file permissions transparent, which is why you will see that our
`Dockerfile` simply uses the `root` user.

To install Podman rootlessly see: [Podman Installation |
Podman](https://podman.io/docs/installation).

For Podman's documentation see: [What is Podman? — Podman
documentation](https://docs.podman.io/en/latest/).

**NOTE** while Docker now has a rootless mode, I have no experience with
using Docker.

**These tools SHOULD NOT be used with a rooted Podman/Docker instance!**

## Tox results

If you use the suggested `tox` commands, the Tox results are stored in the
appropriate Python version in the `toxDir` in the `plastex-tox` root
directory.
