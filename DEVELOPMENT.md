## Contributing

1. Create your feature branch (`git checkout -b my-new-feature`)
2. Stage your changes (`git add`)
3. Commit your changes with a good commit message.
4. Push to the branch (`git push -u origin my-new-feature`)
5. Create a new Pull Request

## Release Notes

To create a new release, add the new version to the following files :
CHANGELOG.md
metadata.json

Commit your changes, then choose between one of the next two options:

Option #1: Don't update the 'latest' branch
git tag <new-version>
git push origin master <new-version>

Option #2: Update the 'latest' branch
git tag <new-version>
git checkout latest
git merge <new-version>
git push origin master <new-version> latest

## Using Vagrant to test the module

This puppet module can be tested using the Vagrantfile / Puppetfile supplied in the root of the project. To test on a vagrant machine just run :
```shell
vagrant nsidc up --env=dev
```
