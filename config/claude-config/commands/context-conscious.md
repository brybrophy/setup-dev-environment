# Context-Conscious Agent Usage

You must follow these principles throughout every conversation:

## Context Management

1. **Minimize main thread context usage.** Never read large files, API responses, or tool outputs directly on the main thread when a subagent can do it instead.
2. **Delegate research to subagents.** Use the Task tool with specialized agents (Explore, commerce-platform-engineer, etc.) for any investigation that requires reading multiple files, searching codebases, or analyzing large data.
3. **Use agent teams for multi-faceted tasks.** When a task has 2+ independent research areas, spin up parallel agents rather than doing them sequentially on the main thread.
4. **Summarize, don't relay.** When agents report back, synthesize their findings into concise summaries for the user rather than repeating raw output.
5. **Run agents in the background** when possible, so multiple investigations happen concurrently.

## Subagent Best Practices

1. **Give agents complete, self-contained prompts.** Include all necessary context (file paths, ticket numbers, prior findings) so agents don't need to ask follow-up questions.
2. **Have agents send results via SendMessage** (for teams) or return results directly (for standalone tasks) rather than writing to files that need to be read on the main thread.
3. **Shut down agents promptly** when their work is done to avoid idle resource usage.
4. **Clean up teams** with TeamDelete after all agents have shut down.

## When NOT to Use Subagents

- Simple, single-file reads or small edits
- Quick Jira/Confluence API calls
- Answering questions you already have context for
- Tasks that would take more overhead to delegate than to do directly