# CSE410 - Lab 7
## Due: 12/03/2019 17:00

This lab will cover installing and using the Docker container engine, building
and updating docker images, installing Concourse CI/CD, and building your own
basic infrastructure automation pipelines.

## Diagrams and Documentation

Similar to the last lab, this lab will will focus heavily on diagrams and
documentation. These will be the primary means of demonstrating you completed
sections of the lab and will serve as a guide should you need to set up
infrastructure in the future. As such, your documentation should be
comprehensive and be able to serve as a guide for someone who has not completed
the process before.

## Docker Installation

Building on the previous lab, we will be using terraform to spin up an Ubuntu
based VM and install docker on it. The relevant docker installation instructions
can be found
[here](https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce),
and the cloud-init docs are located
[here](https://cloudinit.readthedocs.io/en/latest/topics/examples.html#additional-apt-configuration).
I would recommend having cloud-init handle installing docker via APT - however
it may require adding an additional APT *source* and corresponding GPG key (take
a look at the docs). All in all it should require adding 5 or 6 lines to a base
cloud-init user-data file. As usual, the VM should be configured with users for
yourselves and myself (daviddob) and set up the proper permissions for using
docker without sudo.

In addition to the base `docker-ce` package, it may also be helpful to install
`docker-compose` as well for later container orchestration when we set up CI/CD.
It is recommended to give these VMs a bit more resources (i.e. 2CPU 2GB+ RAM
16GB+ Disk) to avoid bottlenecks - tweak as necessary for your deployment.

Unfortunately for our networking config, cloud-init will install packages before
running the command to apply the networking config. This means that you may find
a minute or two delay between terraform finishing and the VM becoming
accessible on the configured IP address. I have dug into this further and found
a few better ways of doing it - however it would be more work on your end for
minimal improvement (you need to wait for the install to finish anyway)

## Docker Basics

To get familiar with using Docker, run through the examples I showed in class
and:

* Run containers interactively
* Run containers as daemons
* Get logs from daemon containers
* Start/stop containers
* Get a list of running and stopped containers
* Build an image from a Dockerfile
* Build an image interactively using `commit`
* Run a basic Webserver container using `EXPOSE` and manual port forwarding

Examples for each of these can be found directly in the slides and it will be
good practice to play around with them a bit and document how they work for
future implementation.

## Setting up Concourse CI/CD

The CI/CD tool we will be using for this class is called
[Concourse](https://concourse-ci.org/). It provides a pretty open and generalist
approach to automation and CI/CD which makes it pretty flexible. To get it spun
up in your lab we are going to use `docker` and `docker-compose`. The concourse
team provides a repo for getting set up with `docker-compose` and it is as easy
as cloning the repo and running a few commands. Their repo and corresponding
readme with installation instructions can be found
[here](https://github.com/concourse/concourse-docker).

If everything is working correctly, you should be able to access the Concourse
UI on port 8080 after spinning it up. Note: you will need to change the
Concourse configuration to work externally (i.e. permit login from somewhere
other than localhost) - and change the default user/password. All of these
configuration options can be found in the `docker-compose.yml` file.

Once you have your concourse instance running, add a DNS entry for concourse
under the wildcard domain you have a cert for (i.e. concourse.mylab.com) that
points at your haproxy and redirect requests for that domain to a new concourse
backend in your haproxy config. Make any required changes to the docker-compose
as well such that redirects function properly.

## Your First Pipeline

When creating your first pipeline I highly recommend checking out
concoursetutorial.com. This is a tutorial that is created and maintained by
Stark & Wayne for learning how to use Concourse CI/CD and has tons of
information and examples that pertain closely to this lab.

Your first pipeline will be fairly simple, and will be to simply output "Hello
world" and your names. A reference pipeline for this can almost entirely be
found in the "Basic Pipeline" section of the tutorial.

## Introducing Resources

To actually do something meaningful with pipelines, we need to use inputs and
output (known as resources). These come in tons of different implementations
from Git, S3, Time, Slack, Twitter, and many more. Check out a fairly
comprehensive list
[here](https://github.com/concourse/concourse/wiki/Resource-Types). 

For your next pipeline, set up a pipeline that uses this [golang webapp
repo](https://github.com/daviddob/go-example-webapp) as an input resource and
triggers whenever a new commit is pushed. Your pipeline will build a new docker
image based off the most recent webapp codebase and push it to DockerHub.

DockerHub gives free public repos (similar to GitHub) for docker images. Once
you register for an account, you should be able to push docker images to a
publicly accessible location.

Once you have your account created, start by creating the pipeline to build the
docker image and push it to DockerHub. The
[docker-image-resource](https://github.com/concourse/docker-image-resource) is
the key to this operation as it can handle building and pushing the image to
DockerHub.

Here is a snippet that should get you started, however there is more information
regarding all the available parameters on the docker image resource readme.

```yaml
- put: 'web-app:latest'
  params:
    # The path of a directory containing a Dockerfile to build.
    build: git/
    tag_as_latest: true
```

## Pipelining Terraform Deployments

Now that you have a handle on basic pipeline operations its time to put that
into practice with terraform. For the next pipeline, we will be using terraform
to build out VMs and run the web app you build using the previous pipeline.

Create a terraform deployment to run the web-app image you created in the
previous step. This should be fairly simple as you already have a terraform
deployment for `docker`. 

Once you have your terraform deployment of the docker based web-app working,
create a pipeline that triggers when a new version of your web-app docker image
is available on DockerHub, deploy the changes (either by tainting the old
resource and deploy, or destroy and redeploy) - then commit the state back to
your lab repo. Remember, the terraform state file changes with each deploy so it
needs to be properly committed back after each deploy.

Then, test your automation by running the pipeline to build a new docker-image.
This should cause the terraform pipeline to trigger, thus deploying out the new
web-app to your infrastructure.

At this point the last thing you need to do is make the web-app accessible via
your haproxy on `https://infra-test.(your-app-domain)`.

I will test that your automation works by pushing a new commit to the web-app
repo and then checking DockerHub and the above URL after some time has passed
for everything to run.

## Submission

Submission of this lab can be performed by writing up your documentation in
Markdown format and committing it to your repository under a 'labs' folder,
either as its own Markdown file or in a subfolder as a README.

In addition to the documentation, add your CI/CD pipelines, Dockerfiles,
Terraform files etc to your repository in a folder next to your documentation.
