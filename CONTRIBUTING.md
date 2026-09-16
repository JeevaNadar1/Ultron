# Contributing

The skill is prose. That makes it easy to add to and hard to keep good — every
line you add dilutes the ones already there, because the model reads all of it.

## The one rule that matters

**Edit `skills/ultron/`. Never edit `ultron.skill`.** The archive is built output.
Run `bash build.sh` and commit the result alongside your source change. CI fails
the pull request if the two drift.

## Setup

```bash
git clone https://github.com/JeevaNadar1/Ultron.git
cd Ultron
bash build.sh
```

Needs `bash`, `zip` and `unzip`. Nothing else.

## Before you open a pull request

1. `bash build.sh` passes, and you committed the rebuilt `ultron.skill`.
2. You ran the eval cases in `evals/cases.md` that your change could plausibly affect, and said which in the pull request.
3. You said what you broke. A change that fixes case 7 and breaks case 11 is a trade, not an improvement, and it needs to be argued as one.

## The bar for new content

Most proposed additions make the skill worse. The reasons are boring and they
repeat:

1. **It restates something already in the file.** Repetition in a prompt doesn't reinforce, it dilutes. Find the existing line and sharpen it instead.
2. **It's a rule with no failure behind it.** If you can't point at a transcript where the model got it wrong, the rule is speculative and it costs tokens on every load.
3. **It's an example that doesn't discriminate.** A worked example earns its place by showing a case where the obvious answer and the right answer differ. An example where they agree teaches nothing.
4. **It adds a tier, a category or an axis.** Four severity tiers is already at the edge of what gets applied consistently. Five is worse, not more precise.

Deletions are welcome and get reviewed faster than additions.

## New reference files

A new file in `references/` needs a named trigger in `SKILL.md` — the condition
under which it should be read. Progressive disclosure means an unreferenced file
never loads; `build.sh` warns about these, and the warning is usually correct.

Adding a file is a MINOR version bump. Changing how the skill behaves in a way an
existing user would notice is MAJOR.

## Reporting a failure

The useful bug report is a transcript. Include the prompt, what came back, and what
should have come back. "It was too agreeable" without the exchange isn't
actionable — the whole point of this thing is that unsupported assertions don't
move anyone.
