if (!/\[[A-Z]+-[0-9]+\]\s/.test(reginald.pr.title)) {
  reginald.error("Title should start with the ticket nuber e.g.: [JIRA-123]")
}
