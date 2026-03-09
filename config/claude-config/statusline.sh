#!/bin/zsh

# Claude Code Status Line Script
# Receives JSON input via stdin with session context

# Read and parse JSON input
input=$(cat)

# Extract information from JSON
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir // ""')

# Extract token information from context_window
total_input_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
total_output_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
context_window_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
used_percentage=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
remaining_percentage=$(echo "$input" | jq -r '.context_window.remaining_percentage // 100')

# Get project name
project_name=""
if [[ -n "$project_dir" ]]; then
    project_name=$(basename "$project_dir")
fi

# Get git branch if in a git repository
git_branch=""
if [[ -n "$current_dir" && -d "$current_dir/.git" ]] || git -C "$current_dir" rev-parse --git-dir >/dev/null 2>&1; then
    git_branch=$(git -C "$current_dir" branch --show-current 2>/dev/null)
    if [[ -n "$git_branch" ]]; then
        # Check for uncommitted changes
        if ! git -C "$current_dir" diff-index --quiet HEAD -- 2>/dev/null; then
            git_branch="$git_branch \033[31m✖\033[0m"
        else
            git_branch="$git_branch \033[32m✔\033[0m"
        fi
    fi
fi

# Calculate total tokens used
total_tokens=$((total_input_tokens + total_output_tokens))

# Use the pre-calculated percentage (convert to integer for display)
context_percentage=$(printf "%.0f" "$used_percentage")

# Format tokens for display (convert to K if over 1000)
if [[ $total_tokens -ge 1000 ]]; then
    tokens_display=$(printf "%.1fK" $(echo "scale=1; $total_tokens / 1000" | bc))
else
    tokens_display="$total_tokens"
fi

# Create progress bar based on context usage (20 characters total)
progress_total=20
progress_filled=$(( (context_percentage * progress_total) / 100 ))
progress_bar=""
for ((i=1; i<=progress_total; i++)); do
    if [[ $i -le $progress_filled ]]; then
        progress_bar="${progress_bar}▓"
    else
        progress_bar="${progress_bar}░"
    fi
done

# Format percentage for display
context_percentage="${context_percentage}%"

# Build status line with requested elements in order:
# Model name | Progress bar | Percentage context used | Tokens | Git branch | Project name
status_parts=()

# 1. Model name
status_parts+=("\033[35m${model_name}\033[0m")

# 2. Progress bar
status_parts+=("\033[36m[${progress_bar}]\033[0m")

# 3. Percentage context used
status_parts+=("\033[33m${context_percentage}\033[0m")

# 4. Tokens
status_parts+=("\033[32m${tokens_display}\033[0m")

# 5. Git branch
if [[ -n "$git_branch" ]]; then
    status_parts+=("\033[34m${git_branch}\033[0m")
fi

# 6. Project name
if [[ -n "$project_name" ]]; then
    status_parts+=("\033[37m${project_name}\033[0m")
fi

# Join all parts with " | "
printf "%b" "${status_parts[1]}"
for ((i=2; i<=${#status_parts[@]}; i++)); do
    printf " | %b" "${status_parts[i]}"
done