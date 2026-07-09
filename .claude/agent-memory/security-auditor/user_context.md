---
name: user-context
description: Who the user is and project setup for the portfolio-site repo
metadata:
  type: user
---

User (sundayinibehe75@gmail.com) owns a static HTML/CSS-only portfolio site (no JS, no build step, no framework) deployed to AWS S3 + CloudFront via Terraform, deployed through GitHub Actions. See [[project-portfolio-infra-baseline]] for the infra audit baseline. Per the repo's own CLAUDE.md: all infra changes must go through Terraform (never manual AWS console changes), and no secrets should ever be placed in CLAUDE.md.
