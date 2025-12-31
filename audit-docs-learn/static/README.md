# Static Assets

This folder contains static files that will be copied to the build output.

## Structure

```
static/
├── img/               # Images and logos
│   ├── logo.svg       # Site logo
│   ├── favicon.ico    # Browser favicon
│   └── diagrams/      # Custom diagrams (if any)
│
├── downloads/         # Downloadable sample files
│   ├── trial-balance-sample.csv
│   ├── chart-of-accounts-template.csv
│   └── procedure-templates.pdf
│
└── fonts/            # Custom fonts (if needed)
```

## Usage

Files in this folder can be referenced in documentation as:

```markdown
![Logo](/img/logo.svg)
[Download Sample](/downloads/trial-balance-sample.csv)
```

## Adding Files

1. Place files in appropriate subdirectory
2. Reference using absolute path from `/static/`
3. Files will be copied to build output root

## Logo

The default logo is a simple SVG placeholder. Replace with your actual CloudAudit Pro logo.

Recommended sizes:
- Logo: SVG (scalable) or PNG (200x200px minimum)
- Favicon: ICO or PNG (32x32px)
