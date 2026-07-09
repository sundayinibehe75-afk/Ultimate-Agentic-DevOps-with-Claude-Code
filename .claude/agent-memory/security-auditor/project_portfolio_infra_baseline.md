---
name: project-portfolio-infra-baseline
description: Baseline state of the portfolio-site terraform/ (S3+CloudFront) as of first security audit on 2026-07-09
metadata:
  type: project
---

First full audit of `terraform/` in this repo happened 2026-07-09. Files: providers.tf, variables.tf, main.tf, outputs.tf, backend.tf.

**Already correctly implemented (don't re-flag as missing unless code changes remove them):**
- S3 `aws_s3_bucket_public_access_block` with all four flags true.
- S3 `aws_s3_bucket_ownership_controls` set to `BucketOwnerEnforced`.
- CloudFront uses OAC (`aws_cloudfront_origin_access_control`), not legacy OAI.
- S3 bucket policy scoped with `AWS:SourceArn` condition tied to the specific CloudFront distribution ARN (least privilege, not a blanket CloudFront service principal grant).
- `viewer_protocol_policy = "redirect-to-https"` on default_cache_behavior.
- No wildcards in IAM/resource policies found; no hardcoded credentials found.

**Gaps found in that same audit (check on next review whether resolved):**
- `backend.tf`: remote S3 backend intentionally left commented out — this is a documented two-phase bootstrap (comments explain: apply once locally to create the state bucket, then uncomment + `init -migrate-state`). Not a bug by itself, but flag as HIGH until migrated, since GitHub Actions CI runs would otherwise use ephemeral local state.
- `.gitignore` only excludes `**/.terraform/` — does NOT exclude `*.tfstate`, `*.tfstate.backup`, or `*.tfvars`. Risk of committing local state/secrets before backend migration happens.
- No `aws_s3_bucket_versioning` resource for the site bucket.
- No `aws_s3_bucket_server_side_encryption_configuration` resource (explicit SSE not declared, relies on AWS's account-level default encryption).
- No S3 access logging and no CloudFront `logging_config` block.
- No `aws_cloudfront_response_headers_policy` attached to default_cache_behavior — no CSP/X-Frame-Options/HSTS security headers.
- `viewer_certificate { cloudfront_default_certificate = true }` — can't set `minimum_protocol_version` with the default cert, so weaker TLS versions may be accepted. `domain_name` variable is declared in variables.tf but unused anywhere in main.tf (no ACM cert / aliases wired up yet).

**How to apply:** On future audits of this repo, diff current terraform/ against this list rather than re-deriving from scratch — confirm which gaps are fixed and which are still open, and watch for regressions in the "already correctly implemented" list.
