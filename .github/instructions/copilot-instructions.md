## Copilot / AI contributor instructions — vscode-python-environments

Quick, actionable notes to get an AI agent productive in this repository.

- Project type: VS Code extension written in TypeScript. Source under `src/` → built with `webpack` into `./dist/extension.js` (see `package.json` `main`).
- Entry points & API: primary extension code in `src/extension.ts` and public API surface in `src/api.ts` and `src/internal.api.ts`.
- Key directories: `src/` (core), `src/common/` (shared utilities like `localize.ts`, `logging.ts`), `managers/` (env managers), `features/` (functional areas), `examples/` (consumers), `files/templates/` (scaffolding including copilot templates).

Build / test / run
- Build for development: `npm run compile` (uses `webpack`).
- Watch (dev): `npm run watch` (webpack watch). There is also `npm run watch-tests` (TypeScript watch for tests) and a compound VS Code task `tasks: build` that runs both watchers.
- Compile TypeScript for tests: `npm run compile-tests` (tsc output -> `out`). `npm run pretest` runs `compile-tests` and `compile`.
- Unit tests: `npm run unittest` (Mocha with `build/.mocha.unittests.json`). Run `npm run pretest` first if you need a fresh build.
- Package: `npm run vsce-package` to create a VSIX (requires `vsce`).

Important repo conventions & patterns
- Localization: All user-facing strings must use the l10n/localize system. See `src/common/localize.ts` and the `l10n` folder. Do not hard-code English strings in UI code.
- Logging: Use the extension logging utilities (`traceLog`, `traceVerbose`) in `src/common/logging.ts`. Avoid `console.log` for internal logs.
- Settings precedence: code assumes VS Code settings precedence (folder → workspace → user). See `.github/instructions/generic.instructions.md` for details.
- Error/UI messages: keep messages actionable and avoid spamming the same message. The repo tracks state to avoid repeated alerts (follow patterns in `src/common/persistentState.ts`).

Where to change behavior
- Contribution points are defined in `package.json` (`activationEvents`, `contributes.commands`, `configuration`). To add a new command, update `package.json` and implement command registration in `src/extension.ts` or `src/common/commands.ts`.
- Entry build output is `./dist/extension.js`. Small runtime changes should still be made in `src/` and then built (or tested using `tsc`/`webpack` watchers).

Examples & idioms for code edits
- Add localized strings: put key in `package.nls.json`/`l10n` and use `localize('key', 'Default text')` in code.
- Add telemetry/logging: use helpers in `src/common/telemetry/*` and `traceLog('message', { meta })` from `logging.ts`.
- Tests: unit tests live under `test/`; many tests use mocha + sinon/typemoq/ts-mockito patterns. See `test/unittests.ts` for test harness patterns.

Integration points & external deps
- Depends on the Python extension (`ms-python.python`) contractually for some features; activation is `onLanguage:python` (see `package.json`).
- Uses `@vscode/test-electron` and `@vscode/test-cli` in dev/test workflows.
- Uses common node deps: `fs-extra`, `dotenv`, `@iarna/toml`, etc.

When making PRs as an AI
- Keep changes small and focused; follow existing file-level patterns (naming, async/await use, error handling helpers in `src/common/errors`).
- Add docstrings to exported functions (see `.github/instructions/generic.instructions.md`).
- Add localization for any user-visible string.
- Run `npm run lint` and `npm run unittest` (or at minimum `npm run compile-tests` + `npm run compile`) before proposing changes.

References (where to look)
- `src/` for implementation details and patterns
- `test/` for unit test examples
- `files/templates/copilot-instructions-text/` contains example copilot templates you can reuse
- `package.json` for scripts and contribution points
- `.github/instructions/generic.instructions.md` for project-specific coding rules (localization, logging, docstrings)

If something is unclear, ask: give the file you intend to edit and a 1–2 line summary of the change. Prefer small incremental PRs.

---
Generated/merged automatically by the AI agent. Ask for edits or to expand examples for a specific subfolder.
