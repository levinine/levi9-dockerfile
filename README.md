# Dockerfile

#### Table of Contents
1. [Description](#description)
2. [Setup](#setup)
3. [Usage](#usage)
   * [Config](#config)
     * [Multistage](#multistage)
     * [Plain](#plain)
4. [Reference](#reference)
5. [Development](#development)
6. [Contributors](#contributors)

## Description

The Puppet dockerfile module manage content of dockerfile, exposing instructions as key/values while supporting multistage builds.
All dockerfile [instructions](https://docs.docker.com/engine/reference/builder/) are supported:
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
- ONBUILD
- RUN
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
        ensure: present
        arg:
          BUILD_NUM: latest
          SOMEARG1: ''
          SOMEARG2: 5
        from:
          platform: linux/amd64
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
            - /tmp with space
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
        user: '0:0'
        run:
          - apt-get update
          - apt-get clean
        workdir: /tmp
        stopsignal: signal
        shell:
          - powershell
          - noprofile
        order: '10'
      Stage2:
        ensure: present
        from:
          image: centos:7.6.1810
        env:
          NUM: $BUILD_NUM
          SOMEENV: test
        label:
          'com.levi9.cluster': cluster
          'com.levi9.role': role
        expose: 80/tcp
        copy:
          from: 0
          chown: '0:0'
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
        user: '0:0'
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
        order: '20'
```

Multiple COPY/RUN instructions Hiera example:
```
dockerfile::configs:
  Multistage:
    type: multistage
    home: /var/lib/jenkins/Docker-Build
    conf:
      Stage1:
        from:
          image: centos:7.6.1810
          as: TEST
      Copy1:
        copy:
          from: TEST
          source:
            - /tmp1
          destination: /home
      Run1:
        ensure: absent
        run:
          - apt-get update
          - apt-get clean
      Copy2:
        onbuild: true
        copy:
          source:
            - /tmp2
          destination: /home
      Stage2:
        expose: 80/tcp
```

#### Plain

Plain config type Hiera example:
```
dockerfile::configs:
  Plain:
    type: plain
    home: /var/lib/jenkins/Docker-Build2
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

See [Reference](https://github.com/levinine/levinine-dockerfile/blob/master/REFERENCE.md).

## Limitations

This module depends on Puppetlabs Concat module, it should be working on all operating systems supported by this module.

## Development

Use [Report Issues](https://github.com/levinine/levinine-dockerfile/issues) link to report any issues.

## Contributors
- Mladen Pavlik
- Dragan Nastic
- Karolj Kocmaros
- Marko Stojanovic