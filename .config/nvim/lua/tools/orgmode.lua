require("orgmode").setup_ts_grammar()

require("orgmode").setup({
    org_agenda_files = { "$KNOWLEDGE_BASE" },
    org_default_notes_file = "$KNOWLEDGE_BASE/refile.org",
})