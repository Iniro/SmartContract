name: "Reginald"
on:
  pull_request:
    types:
      - labeled
      - opened
      - edited
      - reopened
      - synchronize

jobs:
  triage-pr:
    runs-on: ubuntu-latest
    steps:
    - uses: alephao/reginald@develop
      with:
        repo-token: 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
