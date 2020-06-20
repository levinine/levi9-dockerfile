# How to contribute to Dockerfile puppet module

Create high-quality modules with [Puppet Development Kit](https://puppet.com/docs/pdk/1.x/pdk.html) (PDK). PDK provides integrated testing tools and a command line interface to help you develop, validate, and test modules.

#### To validate code use:

```
pdk validate
```

#### Run unit tests:

```
pdk test unit --verbose
```

#### Run acceptance tests:

```
pdk bundle exec rake 'litmus:provision[docker, litmusimage/centos:7]'
pdk bundle exec rake litmus:install_agent
cp spec/fixtures/data/test.yaml data/common.yaml
pdk bundle exec rake litmus:install_module
pdk bundle exec rake litmus:acceptance:parallel
rm data/common.yaml
pdk bundle exec rake "litmus:tear_down"
```

#### Generate documentation with [Puppet Strings](https://puppet.com/docs/puppet/latest/puppet_strings.html):

```
puppet strings generate --format markdown > REFERENCE.md
```

#### Update documentation:

update README.md file

#### Update module version:

update metadata.json file

#### Update changelog:

update CHANGELOG.md file

#### Build package:

```
pdk build
```

#### Release package:

upload package to [Puppet Forge](https://forge.puppet.com/upload)
