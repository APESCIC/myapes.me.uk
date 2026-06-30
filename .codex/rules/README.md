# Codex Command Rules

No active project command rules are enabled by this template.

Codex can load `.rules` files from `.codex/rules/` after the project is
trusted. APES CIC keeps this directory as documentation only unless active
command enforcement is separately approved.

Before adding active rules:

1. Record the issue and branch decision.
2. Explain the command prefix, decision, and rationale.
3. Include positive and negative examples.
4. Prefer prompting or forbidding destructive operations.
5. Confirm the rule does not weaken APES CIC safeguards.
6. Test with `codex execpolicy check` where available.

Rules are useful for repeated command-safety boundaries. They are not a
substitute for user approval, repository guidance, or code review.
