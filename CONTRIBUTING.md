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
