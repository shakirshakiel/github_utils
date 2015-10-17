# github_utils
Utilities to reduce the manual tasks that we do everyday in all projects

## Setup

```
cp config.default.yml config.yml
```

1. Create Personal Access Token from Github from Settings -> Personal Access Tokens
2. Put it in config.yml against oauth_token key
3. Change your project_working_directory
4. Change your github_organisation_name

```
ruby github_utils.rb
```
