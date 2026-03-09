---
description: Rewrite the last response in a clean, copy-pasteable format
---

# Copy-Paste Formatted Output

The user wants to copy your most recent response and paste it somewhere (likely Slack, an email, or a document) with correct formatting.

## Instructions

1. Take the most recent substantive response you gave the user (the one they want to copy).
2. Write it to a temporary file at `/tmp/claude-copyable-output.md` using the Write tool.
3. Then output the same content as a single fenced code block (```markdown ... ```) so the user can also copy it directly from the terminal if preferred.

## Formatting Rules

- Do NOT indent lines with extra spaces unless they are inside a code block or nested list.
- Use single newlines between paragraphs, not double.
- Avoid trailing whitespace on any line.
- Keep bold/italic markdown syntax intact — it renders well in Slack and most tools.
- For numbered or bulleted lists, use standard markdown (no extra indentation on the first level).
- If the response contains code snippets, keep them in fenced code blocks.
- Do not add any preamble or commentary — just the clean content.

## After Writing

Tell the user:
- The file is saved at `/tmp/claude-copyable-output.md` and they can open it or `pbcopy < /tmp/claude-copyable-output.md` to copy it to their clipboard.
- They can also copy from the code block above.
