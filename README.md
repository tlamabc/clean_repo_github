# clear_repo.sh — Interactive GitHub Repo Deletion Script
<p align="center">
  <img src="./logo_tool_clean_repo.png" alt="Logo" width="300"/>
</p>

A simple interactive Bash script to list and delete your own GitHub repositories using the GitHub REST API. It leverages `fzf` for fast, fuzzy multi-selection in the terminal.

## Features

- Fetches up to 100 repositories you **own** (forks excluded)
- Interactive multi-select UI with `fzf`
- Confirmation prompt before deletion
- Uses GitHub REST API v3
- Easy to customize or extend

## Requirements

- `bash`
- [`jq`](https://stedolan.github.io/jq/) — for JSON parsing
- [`fzf`](https://github.com/junegunn/fzf) — for interactive selection
- macOS or Linux (tested)

##Setup

### 1. Clone the script (if using from a repo)

```bash
git clone https://github.com/tlamabc/clean_repo_github.git
cd clean_repo_github
````

### 2. Install dependencies

On macOS (with Homebrew):

```bash
brew install jq fzf
```

On Ubuntu/Debian:

```bash
sudo apt update
sudo apt install jq fzf
```

### 3. Set up GitHub credentials

Generate a [GitHub Personal Access Token (PAT)](https://github.com/settings/tokens) with the following scope:

* `repo` → to allow repo deletion

Then export your credentials as environment variables:

```bash
export GITHUB_USERNAME="your-github-username"
export GITHUB_TOKEN="ghp_..."  # Keep this secret!
```

Alternatively, you can hardcode them in the script (not recommended for public/shared use).

### 4. Run the script

```bash
./clear_repo.sh
```

---

## Example Output

```bash
Select repos to delete: 
✔ my-old-repo
✔ test-project

You have selected to delete:
my-old-repo
test-project

Are you sure you want to delete them? (y/N): y
Deleting repo: my-old-repo
- Deleted: my-old-repo
Deleting repo: test-project
- Deleted: test-project
```

---

## Security Notes

* Do **not** commit or share your personal access token.
* Use environment variables to keep credentials safe.
* Consider using a `.env` file + `source .env` if preferred.

---

## Technical Notes

* The script retrieves up to **100 repos** via `per_page=100`. For more, you'd need to add pagination.
* Only **non-forked repositories you own** will be listed and deletable.

---

## Author

* **Name:** Dang Thanh Lam (`tlamabc`)
* A simple personal utility to clean up GitHub repositories quickly from the terminal.

---

## License

MIT License — Free to use, modify, or redistribute. Use wisely (and don’t delete your important repos by accident 😂).




