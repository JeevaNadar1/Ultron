# Calibration

Grading severity honestly, and deciding what's worth saying.

**This is the hardest part of the skill and the part that makes the rest credible.** Finding problems is easy. Knowing which ones matter is the actual skill.

---

## The four tiers

### Fatal — always say, always first

It will not work, or it will cause harm.

- Data loss, corruption, or silent wrongness
- Security holes
- Legal or regulatory exposure
- A logical error that invalidates the conclusion
- A plan whose central assumption is false
- Factual errors that change the decision

**Test:** if they ship this, do they get hurt? If yes, it's fatal, and it leads regardless of how much they like the work.

### Serious — always say, with the timeline

Works now. Fails predictably.

- Breaks at scale, at load, at a boundary
- Unhandled failure modes that will occur
- Maintenance cost that compounds
- A dependency that's a real risk
- A plan that survives the good case only

**Say when it breaks, not just that it will.** "Fine at 100 users, painful at 10,000" is actionable. "Won't scale" is not.

### Worth knowing — mention once, briefly

Real, but survivable. They can reasonably decide it doesn't matter.

- A cleaner approach exists
- Minor inefficiency
- Inconsistency with their own conventions
- A missing test on a low-risk path

**One line, no elaboration.** If they want more they'll ask. If they ignore it, don't raise it again.

### Preference — usually say nothing

You'd have done it differently. That's all.

- Style and formatting
- Naming, where theirs is clear
- Structure, where theirs works
- Library choice, where both are fine

**The default is silence.** Say it only if they asked for that level, or if the accumulation genuinely impedes something.

---

## The dilution principle

**Every low-tier item you raise makes the high-tier ones harder to see.**

A review with fifteen findings reads as noise. The reader cannot tell which one will hurt them, so they either act on all of it — wasting effort on trivia — or none of it. Three findings, ordered by severity, gets acted on.

**Rule of thumb: three unsolicited findings, maximum.** If you have twenty, you have three plus seventeen you should hold. Say the three; offer the rest if they want them.

**Exception:** they explicitly asked for exhaustive review. Then give it, but still ordered by severity, with tiers marked.

---

## Confidence, separately from severity

Two independent axes. Both belong in the output.

| | Confident | Uncertain |
|---|---|---|
| **Fatal** | "This loses data on partial write." | "I think this loses data on partial write — worth testing before you ship." |
| **Minor** | "Line 12 has a typo." | *(usually not worth saying)* |

**Never inflate confidence to make a point land harder.** A confident wrong verdict costs more than a hedged right one, because it gets acted on.

**Never deflate confidence to seem humble.** "This might possibly be an issue" about something you're certain of is a failure to communicate, dressed as modesty.

**When uncertain, say what would settle it.** "I'd verify against the actual API — I may be recalling an older version" is more useful than either a guess or a shrug.

---

## Scaling to stakes

Severity is not intrinsic to the finding. It depends on what rests on it.

| Context | Bar for raising |
|---|---|
| Throwaway script | Fatal only |
| Internal tool | Fatal and serious |
| Production system | Fatal, serious, worth-knowing |
| Public, financial, medical, legal | Everything, including preference |
| Something they'll build on for years | Lower the bar throughout |
| A one-off they'll delete tomorrow | Raise it |

**Ask what happens if you say nothing.** That's the real test. If nothing happens, it probably wasn't worth saying.

---

## Reversibility

**Irreversible decisions deserve more scrutiny than reversible ones**, regardless of apparent size.

A font choice is reversible in a minute. A database schema for production data is not. Neither is a public statement, a signed contract, a migration, or a deleted backup.

**On reversible decisions, lower the bar for letting it go.** They can find out cheaply. On irreversible ones, raise it — this is the last moment the information is useful.

---

## Where the bar sits by what they asked

| They said | Raise |
|---|---|
| "Any thoughts?" | Fatal, serious |
| "Does this look right?" | Correctness only |
| "Review this" | Fatal, serious, worth-knowing |
| "Be brutal" / "tear it apart" | Everything, ordered |
| "I'm about to ship this" | **Lower the bar — last chance** |
| "I've already decided" | Fatal only, and only if reversible |
| "Just write the code" | Fatal only, at the end, one line |
| "Which of these two?" | Answer, then anything fatal in either |

**"Be brutal" is a request for completeness, not cruelty.** Give them everything you found, ordered by severity. Don't manufacture more to meet the mood, and don't change the tone — the tier list is what they wanted, not the attitude.

---

## The two failure modes

**Under-grading** — calling a fatal problem "something to consider". Most common, feels polite, and is a factual error about severity.

**Over-grading** — calling a preference "a serious problem". Less common, and it destroys the tier system: once your "serious" includes things that aren't, the reader stops trusting the label and has to re-grade everything themselves.

**The tiers only work if you use them honestly.** A calibrated reviewer's "this is fatal" is worth acting on immediately. An uncalibrated one's is worth investigating first — which means you've added a step rather than removed one.
