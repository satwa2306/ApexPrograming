# Repository Guidelines

## Project Structure & Module Organization

This is a Salesforce DX project. The default package path is `force-app`, using Salesforce API version 66.0. Main metadata lives under `force-app/main/default/`, including Apex classes in `classes/`, triggers in `triggers/`, Lightning Web Components in `lwc/`, Aura components in `aura/`, object metadata in `objects/`, layouts in `layouts/`, and static assets in `staticresources/`. Deployment manifests belong in `manifest/`. Utility examples live in `scripts/apex/` and `scripts/soql/`.

## Build, Test, and Development Commands

- `npm install`: installs local linting, formatting, Husky, and LWC Jest tooling.
- `npm run lint`: runs ESLint against JavaScript in `aura` and `lwc` folders.
- `npm test`: runs the default unit test suite via `sfdx-lwc-jest`.
- `npm run test:unit:watch`: runs LWC Jest tests in watch mode.
- `npm run test:unit:coverage`: generates LWC Jest coverage.
- `npm run prettier`: formats Apex, Lightning, XML, JSON, Markdown, YAML, and related metadata files.
- `npm run prettier:verify`: checks formatting without writing changes.

For org workflows, use Salesforce CLI commands such as `sf project deploy start --source-dir force-app` and `sf apex run test --test-level RunLocalTests` after authenticating.

## Coding Style & Naming Conventions

Use Prettier for supported files; this project disables trailing commas and includes Apex and XML plugins. Follow Salesforce naming conventions: Apex classes and triggers use PascalCase, test classes end with `Test`, and LWC bundle folders use lower camel case, such as `force-app/main/default/lwc/accountList`. Keep component JavaScript, HTML, CSS, and metadata files colocated inside each LWC bundle.

## Testing Guidelines

LWC tests use `@salesforce/sfdx-lwc-jest`; place tests in the related LWC bundle using the `*.test.js` pattern. Apex tests should live in `force-app/main/default/classes/` and use `*Test.cls`, as in `AccountControllerTest.cls`. Run `npm test` for LWC changes and Salesforce Apex tests before deploying Apex, trigger, or metadata changes that affect server behavior.

## Commit & Pull Request Guidelines

Recent commit history uses short summaries such as `Add descriptive comments to AccountProcessingBatch`. Keep commits focused and describe the user-visible or metadata change. For pull requests, include a concise description, testing performed, linked issue or work item when available, and screenshots for Lightning UI changes.

## Agent-Specific Instructions

Do not edit generated Salesforce state in `.sf/` or `.sfdx/`. Prefer scoped changes under `force-app/main/default/`, and keep formatting-only edits separate from behavior changes. Note that `README.md` currently contains unresolved merge-conflict markers; avoid modifying it unless the task includes cleanup.
