# Changelog

All notable changes to this skill. Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
Versions follow [SemVer](https://semver.org/): a MAJOR bump changes how the skill
behaves in ways an existing user would notice, MINOR adds a reference file or a
new behaviour, PATCH is wording and fixes.

## [Unreleased]

## [1.0.0] - 2026-09-16

First tagged release. Contents unchanged from the original upload; the repository
around them is new.

### Added

1. Skill source committed as readable files under `skills/ultron/` — previously
   the 1,183 lines existed only inside the `ultron.skill` archive.
2. `LICENSE` (MIT). The README had claimed MIT since the first commit with no
   license file backing it.
3. `build.sh` — validates frontmatter, checks every referenced file exists, and
   packages the archive.
4. CI on every push and pull request, including a check that the committed
   `ultron.skill` matches the source.
5. `evals/cases.md` — 12 scenarios covering the behaviours the README claims.
6. `CONTRIBUTING.md`.
7. `.claude-plugin/` manifests for installation via the Claude Code plugin system.

[Unreleased]: https://github.com/JeevaNadar1/Ultron/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/JeevaNadar1/Ultron/releases/tag/v1.0.0
