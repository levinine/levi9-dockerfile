# Dockerfile

#### Table of Contents
1. [Description](#description)
2. [Setup](#setup)
3. [Usage](#usage)
   * [Config](#config)
     * [Multistage](#multistage)
     * [Plain](#plain)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
   * [Classes](#classes)
   * [Defined types](#defined-types)
   * [Parameters](#parameters)
5. [Development - Guide for contributing to the module](#development)
6. [Contributors](#contributors)

## Description

The Puppet dockerfile module manage content of dockerfile, exposing instructions as key/values while supporting multistage builds.
Following [instructions](https://docs.docker.com/engine/reference/builder/) are supported:
- ADD
- ARG
- CMD
- COPY
- ENTRYPOINT
- ENV
- EXPOSE
- FROM
- HEALTHCHECK
- LABEL
- SHELL
- STOPSIGNAL
- USER
- VOLUME
- WORKDIR

## Setup

To install Dockerfile module use puppet module install command:

```puppet
puppet module install levinine-dockerfile
```

## Usage

### Config

In order to provide configuration for dockerfile use the `dockerfile::config` defined type in the manifest file:

```puppet
dockerfile::config { 'Dockerfile': 
  ensure => 'present',
  home   => '/var/lib/jenkins/Docker-Build',
  type   => 'multistage',
  conf   => {},
}
```

### Config types

#### Multistage

Multistage config type Hiera example:
```
dockerfile::configs:
  Multistage:
    type: multistage
    home: /var/lib/jenkins/Docker-Build
    conf:
      Stage1:
        arg:
          BUILD_NUM: latest
          SOMEARG: ''
          SOMEARG2: 5
          SOMEARG3: ''
        from:
          image: centos:7.6.1810
          as: TEST
        env:
          NUM: $BUILD_NUM
          SOMEENV: test
        label:
          'com.levi9.cluster': cluster
          'com.levi9.role': role
        expose: 80/tcp
        copy:
          from: 0
          source:
            - /tmp
            - /test
          destination: /home
        add:
          chown: '0:0'
          source: /tmp
          destination: /home
        volume: test
        cmd:
          - /bin/sh
          - -c
          - top
        entrypoint:
          - /bin/sh
          - -c
          - top
        user: 0:0
        pre:
          run:
            - ls
          copy:
            source:
              - /tmp
              - /test
            destination: /home
          add:
            source: /tmp
            destination: /home
        post:
          run:
            - ls in post
          copy:
            source:
              - /tmp
              - /test
            destination: /home
          add:
            source:
              - /tmp with space
            destination: /home with space
        run:
          - apt-get update
          - apt-get clean
        workdir: /tmp
        stopsignal: signal
        shell:
          - powershell
          - noprofile
        healthcheck:
          interval: 30s
          timeout: 30s
          start-period: 0s
          retries: 3
          cmd: curl http://localhost
      Stage2:
        arg:
          BUILD_NUM: latest
          SOMEARG: ''
          SOMEARG2: 5
          SOMEARG3: ''
        from:
          image: centos:7.6.1810
          as: TEST
        env:
          NUM: $BUILD_NUM
          SOMEENV: test
        label:
          'com.levi9.cluster': cluster
          'com.levi9.role': role
        expose: 80/tcp
        copy:
          from: 0
          source:
            - /tmp
            - /test
          destination: /home
        add:
          chown: '0:0'
          source: /tmp
          destination: /home
        volume: test
        cmd:
          - /bin/sh
          - -c
          - top
        entrypoint:
          - /bin/sh
          - -c
          - top
        user: 0:0
        pre:
          run:
            - ls
          copy:
            source:
              - /tmp
              - /test
            destination: /home
          add:
            source: /tmp
            destination: /home
        post:
          run:
            - ls in post
          copy:
            source:
              - /tmp
              - /test
            destination: /home
          add:
            source:
              - /tmp with space
            destination: /home with space
        run:
          - apt-get update
          - apt-get clean
        workdir: /tmp
        stopsignal: signal
        shell:
          - powershell
          - noprofile
        healthcheck:
          interval: 30s
          timeout: 30s
          start-period: 0s
          retries: 3
          cmd: curl http://localhost
```
#### Plain

Plain config type Hiera example:
```
dockerfile::configs:
  Plain:
    type: plain
    home: /var/lib/jenkins/Docker-Build
    conf: |
      FROM ubuntu:18.04 as BUILD

      ARG BUILD_NUM="latest"
      ENV PUPPET_AGENT_VERSION="5.5.10" CERTNAME=$BUILD_NUM CODENAME="bionic"

      LABEL BUILD=intermediate

      RUN apt-get update && \
          apt-get install --no-install-recommends -y lsb-release wget ca-certificates && \
          wget https://apt.puppetlabs.com/puppet5-release-"$CODENAME".deb && \
          dpkg -i puppet5-release-"$CODENAME".deb && \
          rm puppet5-release-"$CODENAME".deb && \
          apt-get update && \
          apt-get install --no-install-recommends -y puppet-agent="$PUPPET_AGENT_VERSION"-1"$CODENAME" && \
          apt-get remove --purge -y wget && \
          apt-get autoremove -y && \
          apt-get clean && \
          mkdir -p /etc/puppetlabs/facter/facts.d/ && \
          rm -rf /var/lib/apt/lists/*

      RUN apt-get update && \
          /opt/puppetlabs/bin/puppet agent --verbose --onetime --no-daemonize --summarize && \
          apt-get autoremove -y && \
          apt-get clean && \
          rm -rf /var/lib/apt/lists/*

      FROM ubuntu:18.04

      COPY --from=BUILD /tmp/mydir/myfile .
```

## Reference

### Classes

#### Public classes

* dockerfile

### Defined types

* dockerfile::config

#### Private defined types

* dockerfile::config::stage
* dockerfile::config::plain
* dockerfile::config::multistage

### Parameters

#### Class: dockerfile

##### `configs`
*Optional* Creates `dockerfile::config` resources.

#### Type: dockerfile::config

##### `ensure`
*Optional* Whether the dockerfile should exist. Valid values are 'present', 'absent'. Defaults to 'present'.

##### `home`
*Required* Directory in which dockerfile will be created.

##### `dockerfile_name`
*Optional* Name of dockerfile. Defaults to 'Dockerfile'.

##### `type`
*Optional* Type of Dockerfile configuration type. Valid values are 'multistage', 'plain'. Defaults to 'plain'.

##### `conf`
*Optional* Configuration of Dockerfile. Depends on type:
* plain - Text that will be placed in Dockerfile.
* multistage - Hash with key as stage names and values as dockerfile instructions.

## Limitations

This module depends on Puppetlabs Concat module, it should be working on all operating systems supported by this module.

## Development - Guide for contributing to the module

Puppet modules on the Puppet Forge are open projects, and community contributions are essential for keeping them great.

For more information, see Puppet's module contribution guide.

## Contributors
- Mladen Pavlik
- Dragan Nastic
- Karolj Kocmaros