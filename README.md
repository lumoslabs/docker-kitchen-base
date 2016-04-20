# kitchen-base

Just a simple [Docker](docker.io) image to use as a base image for running [test kitchen](kitchen.ci) with [Docker](docker.io)

Adapted from [this wonderful blog post](https://medium.com/brigade-engineering/reduce-chef-infrastructure-integration-test-times-by-75-with-test-kitchen-and-docker-bf638ab95a0a#.u80av7iiv) by [Brigade Engineering](https://medium.com/brigade-engineering)

This container runs:

  * `systemd` so all your `service` calls work

  * `sshd` so the `kitchen` user can log in
