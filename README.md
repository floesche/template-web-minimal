# Minimal Quarto Website Template

A minimal [Quarto](https://quarto.org/)-based template for building static websites. Renders to HTML (GitHub Pages), PDF (via Typst), MS Word, and GitHub Flavored Markdown.

All dependencies are managed through [pixi](https://pixi.sh/), so no manual installation of Quarto or other tools is required. If you get stuck, see [Getting help from an LLM](#getting-help-from-an-llm) below.

## Quick start

### 1. Install pixi

pixi manages **all** dependencies (Quarto, Python, and more). You do **not** need to install them separately.

Follow the [official installation instructions](https://pixi.sh/latest/getting_started/) for your operating system, or use the quick commands below.

> **Important:** Pick the command that matches your operating system. Running the wrong one will produce confusing errors.

**Windows**: open **PowerShell** and run:

```powershell
powershell -ExecutionPolicy Bypass -c "irm -useb https://pixi.sh/install.ps1 | iex"
```

**Linux** or **macOS**: open a terminal and run:

```bash
curl -fsSL https://pixi.sh/install.sh | sh
```

After installation, **close and reopen your terminal** so the `pixi` command is available.

### 2. Clone and preview

First, navigate to the folder where you want to store the project. For example:

```bash
cd ~/Documents        # or any folder you prefer
```

Then clone the repository and start the preview:

```bash
git clone https://github.com/floesche/template-web-minimal.git
cd template-web-minimal
pixi run preview
```

This installs all dependencies automatically on the first run and opens a live-reloading preview at `http://localhost:8000`.

> **Troubleshooting:** Always use `pixi run preview` (not `quarto preview` directly). pixi sets up the correct environment with all required tools. If you see errors about missing tools or paths, make sure you are running commands through pixi.

### 3. Build the site

```bash
pixi run render
```

Output goes to `public/`.

## Customizing the template

### Site configuration

Edit `_quarto.yml` to change:

- **`website.title`**: your site name
- **`website.site-url`**: your GitHub Pages URL
- **`website.navbar`**: top navigation links
- **`website.page-footer`**: footer text

### Content structure

```
index.qmd                      # Homepage
_helper/                       # Typst templates and Lua filters
```

Add new pages by creating `.qmd` files and adding them to the navigation in `_quarto.yml`.

### Output formats

Every page renders to four formats:

- **HTML**: primary web format with search, navigation, and table of contents
- **PDF**: two-column article layout via Typst, suitable for printing
- **DOCX**: Word format for collaborative editing
- **GFM**: GitHub Flavored Markdown

Format download links appear automatically on each page.

### Citations

1. Add BibTeX entries to a `references.bib` file
2. Add `bibliography: references.bib` to a page's YAML header
3. Cite with `@citationkey` syntax

## Deploying to GitHub Pages

Deployment is automated via GitHub Actions (`.github/workflows/deploy.yml`).

### Setup

1. Push this repository to GitHub
2. Go to **Settings → Pages**
3. Under **Source**, select **GitHub Actions**
4. Push to `main`. The site deploys automatically

### Custom domain (optional)

1. In **Settings → Pages**, enter your custom domain
2. Add a `CNAME` file to the repo root with your domain name
3. Configure DNS as described in [GitHub's documentation](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)

## Available pixi tasks

| Command | Description |
|---------|-------------|
| `pixi run preview` | Live-reloading local preview |
| `pixi run render` | Build the static site to `public/` |
| `pixi run clean` | Remove generated files |

## Adding dependencies

Need Python packages for computational notebooks?

```bash
pixi add pandas seaborn matplotlib
```

All dependencies are recorded in `pixi.toml` and pinned in `pixi.lock`.

## Getting help from an LLM

If you run into problems and want to ask ChatGPT, Copilot, Claude, or another LLM for help, include the following context in your prompt so it can give you accurate advice:

> I'm working with a Quarto website project that uses **pixi** (https://pixi.sh/) to manage all dependencies. pixi installs Quarto, Python, and everything else automatically. I do not install these tools separately. I run all commands through pixi (e.g., `pixi run preview`, `pixi run render`). The project configuration is in `_quarto.yml` and dependencies are defined in `pixi.toml`.
>
> [Paste your error message here]

This prevents the LLM from suggesting you install Quarto or Python manually, create virtual environments, or take other steps that bypass pixi and cause further issues.
