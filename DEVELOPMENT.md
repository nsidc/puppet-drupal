## Contributing

1. Create your feature branch (`git checkout -b my-new-feature`)
2. Stage your changes (`git add`)
3. Commit your puppet-lint(http://puppet-lint.com/) compliant and test-passing changes with a
   [good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
   (`git commit`)
4. Push to the branch (`git push -u origin my-new-feature`)
5. Create a new Pull Request

## Release Notes

To create a new release, add the new version to the following files :
CHANGELOG.md
metadata.json

Commit your changes, then run the following to push the version:
git tag <new-version>
git checkout latest
git pull <new-version>
git push origin <new-version> latest

## Using Vagrant to test the module

This puppet module can be tested using the Vagrantfile / Puppetfile supplied in the root of the project. To test on a vagrant machine just run :
```shell
vagrant nsidc up --env=dev
```

## Syntax check and linting

To do the linting, you should have the gem puppet-lint installed.  Then, you can run the following
to do the syntax check and linting:

```shell
rake lint
```

## Unit testing

If you update the manifests or templates, please think about updating the unit tests.

The spec requires gems to be installed on your system, however librarian-puppet does not handle
Gemfiles being in the project root well.   To this end, you must set the Gemfile location for bundler
prior to running a command:

```export BUNDLE_GEMFILE={path to project}/spec/Gemfile```

then run

```bundle install``` from the project root.

Once you have installed the dependencies, you can run the unit tests with `bundle exec rake spec:unit`.

## Acceptance testing

The acceptance tests up a CI machine on dev.int.nsidc.org and do some basic sanity tests to make sure
that expected users are created, etc.

To run the acceptance tests: `rake spec:acceptance`
