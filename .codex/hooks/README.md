# Codex Hooks

No active project hooks are enabled by this template.

Codex can load project-local hooks from `.codex/hooks.json` or inline
`[hooks]` tables in `.codex/config.toml` after the project is trusted. APES CIC
keeps this directory as documentation only unless active enforcement is
separately approved.

Before adding active hooks:

1. Record the issue and branch decision.
2. Explain exactly which event the hook handles.
3. Explain what command runs and why it is safe.
4. Confirm it does not expose secrets, private data, or environment values.
5. Confirm it does not deploy, delete files, mutate Git state, or contact
   protected services without approval.
6. Add validation and rollback notes.

Prefer guidance and scripts before hooks. Hooks should enforce a clear repeated
need, not hide workflow decisions.
