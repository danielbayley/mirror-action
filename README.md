<img src="logo.svg" width="15%" align="left">

Mirror
======
GitHub [action] to easily mirror* files between repositories.

\* This action uses [`rsync`] over [`cp`] to easily preserve folder structure. `runs-on: macos-latest`.

Usage
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| [Input]               | Required | Default                                               | Description                                                                                                       |
|:----------------------|:--------:|:------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------|
| `git_author_name`     |  false   | [`github.actor`][github]                              | `GIT_AUTHOR_NAME` [environment variable].                                                                         |
| `git_author_email`    |  false   | [`github.event.pusher`][webhook]`.email`              | `GIT_AUTHOR_EMAIL`                                                                                                |
| `git_committer_name`  |  false   | [`inputs`]`.git_author_name`                          | `GIT_COMMITTER_NAME`                                                                                              |
| `git_committer_email` |  false   | `inputs.git_author_email`                             | `GIT_COMMITTER_DATE`                                                                                              |
| `github_token`        |          | [`env`]`.GITHUB_TOKEN`                                | Required unless `env.GITHUB_TOKEN` is set. [Generate] an [access token], then add to your repository [`secrets`]. |
| `source_files`        |   true   |                                                       | Specify an [[extended]] [glob pattern] of matching files to mirror.                                               |
| `source_repo`         |  false   | [`github.repository`][github]                         | Optionally specify a different repository source to copy files from.                                              |
| `target_repo`         |   true   |                                                       | Specify the target repository. The owner will match the source repo if only the name is given.                    |
| `target_path`         |  false   |                                                       | Optionally specify a different target file path other than the repository root.                                   |
| `source_branch`       |  false   | [`main`]                                              | Optionally specify a source `branch` of your repository.                                                          |
| `target_branch`       |  false   | `main`                                                | Optionally specify a target `branch` of the target repo.                                                          |
| `branch`              |  false   | `main`                                                | Specify if both branches are the same, but differ from the default.                                               |
| `commit_message`      |  false   | Mirror `inputs.source_files` from `github.repository` | The `git commit -`[`-m`]`essage` to appear on the target repository.                                              |

Example
-------
~~~ yaml
on:
  push:
    paths:
    - .github/hooks/*

jobs:
  Mirror:
    runs-on: macos-latest
    steps:
    - name: ${{github.job}} files
      uses: danielbayley/mirror-action@main
      #env:
        #GITHUB_TOKEN: ${{secrets.PERSONAL_ACCESS_TOKEN}}
      with:
        github_token: ${{secrets.PERSONAL_ACCESS_TOKEN}}
        source_files: .github/hooks/*
        target_repo: target/repo
~~~

License
-------
[MIT] © [Daniel Bayley]

[MIT]:                  LICENSE.md
[Daniel Bayley]:        https://github.com/danielbayley

[action]:               https://docs.github.com/actions
[input]:                https://docs.github.com/actions/creating-actions/metadata-syntax-for-github-actions#inputs
[`inputs`]:             https://docs.github.com/actions/learn-github-actions/contexts#inputs-context
[github]:               https://docs.github.com/actions/learn-github-actions/contexts#github-context
[`secrets`]:            https://docs.github.com/actions/learn-github-actions/contexts#secrets-context
[webhook]:              https://docs.github.com/developers/webhooks-and-events/webhooks/webhook-events-and-payloads#webhook-payload-object-37
[`env`]:                https://docs.github.com/actions/learn-github-actions/environment-variables

[generate]:             https://github.com/settings/tokens
[access token]:         https://docs.github.com/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token
[`secrets`]:            https://docs.github.com/actions/security-guides/encrypted-secrets
[`main`]:               https://github.com/github/renaming#readme

[environment variable]: https://git-scm.com/book/en/Git-Internals-Environment-Variables

[zsh]:                  https://zsh.org
[glob pattern]:         https://globster.xyz
[extended]:             https://zsh.sourceforge.io/Doc/Release/Options.html#index-brace-expansion_002c-extending

[`rsync`]:              https://linuxize.com/post/how-to-use-rsync-for-local-and-remote-data-transfer-and-synchronization
[`cp`]:                 https://linuxize.com/post/cp-command-in-linux
