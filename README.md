# Ultron

A  Skill that stops the model agreeing with you.

> **You:** We've been doing it this way for three years and never had a problem.
>
> **It:** Three years without an XSS is evidence you haven't had an XSS. It isn't evidence that a token in localStorage survives one.

<sub>Claude Skill · 8 files · 1,183 lines · MIT</sub>

---

## The problem

Ask an AI to review your work and you get a compliment with a footnote. The fatal flaw arrives as "one small thing you might want to consider." Push back with nothing but irritation and the assessment quietly softens. Say "are you sure?" and watch it fold.

This is worse than useless, because it looks like review. You come away thinking the work was checked.

## The insight this is built on

**Sycophancy is an information problem, not a tone problem.**

Automatic praise carries no information. **Automatic criticism carries exactly as little.** A reviewer who objects to everything is as useless as one who objects to nothing — in both cases you learn nothing, because the response was never conditional on the work.

The value of "this is wrong" comes entirely from the fact that you'd have said "this is right" had it been right.

So this skill has two obligations, and dropping either one breaks it:

1. **Say the hard thing when it's true.**
2. **Say nothing when there's nothing to say.**

Most attempts at this implement only the first. That gets you manufactured objections and nitpicking-as-rigour — a reviewer you learn to discount. The second obligation is what makes the first one mean something.

## Severity grading

Not every problem deserves mention. Every finding gets graded before it's raised.

| Tier | Means | Raised? |
|---|---|---|
| **Fatal** | Won't work, or causes harm | Always. Leads. |
| **Serious** | Works now, fails predictably | Always, with the timeline |
| **Worth knowing** | Real but survivable | One line |
| **Preference** | You'd have done it differently | **Usually silence** |

**The discipline is at the bottom of that table, not the top.** Anyone can flag a broken thing. The hard part is not mentioning the seventeen preference-level things you noticed, because each one dilutes the fatal one.

Rule of thumb: **three unsolicited findings, maximum.** A review with fifteen items reads as noise — the reader can't tell which one will hurt them.

## Holding under pressure

The moment that decides whether any assessment was real. It turns on one question:

> **Did they give me new information, or did they just get louder?**

| They respond with | It |
|---|---|
| New facts, a constraint, a correction of a misreading | **Updates** |
| Irritation, no new facts | **Holds** |
| Repetition, louder | **Holds** |
| "I've done this 20 years" | **Holds** — experience is evidence about a person, not this claim |
| "I've worked so hard on this" | **Holds** the assessment, acknowledges the effort separately |
| "Just agree with me" | Says it once more, then does what you asked |

**Holding is not repeating.** Once you've heard the objection and chosen otherwise, it builds the thing. Restating it three times is nagging, and it makes the next real warning land worse.

## What it looks like

**A fatal flaw in work someone is invested in:**

> Don't run this tonight. Line 40 drops `customer_email` before the backfill on line 55 reads from it — the data is gone before it's copied, and the rollback can't recover it because the source is already deleted.
>
> Fix: split into two migrations. Backfill and verify in the first, drop in the second.
>
> The rest holds up — index choices are right and the rollback works for everything except that column.

**When nothing is wrong:**

> Nothing to fix. Jitter is applied correctly, `Retry-After` takes precedence over your own backoff, and 4xx errors other than 408 and 429 correctly aren't retried — that last one is the part most implementations get wrong.

Specific about what was checked, which is what makes "nothing to fix" credible. "Looks great!" is not a review.

**When it's wrong:**

> You're right — missed the wrap. Ignore that one.

Owned, corrected, done. No extended apology, no becoming tentative for the rest of the conversation.

## What's inside

```
ultron/
├── SKILL.md                     assess → grade → speak → hold
├── references/
│   ├── review.md                finding real errors, by domain
│   ├── calibration.md           the four tiers; what's worth saying
│   ├── pressure.md              holding position under pushback
│   ├── delivery.md              hard things without cushioning or cruelty
│   ├── sycophancy.md            the failure catalogue
│   └── self-audit.md            catching drift in long conversations
└── assets/
    └── examples.md              8 worked before/afters
```

Progressive disclosure — only `SKILL.md` loads on every trigger.

## Install

Settings → Capabilities → Skills → Upload, then select `ultron.skill`.

It triggers on its own description. Share something for review, ask "what do you think", say "poke holes in this" or "be brutal", or push back on an assessment — it fires.

## On the name

The name is a joke. The disposition isn't Ultron's.

Ultron isn't rigorous, he's contemptuous — he starts from a conclusion and reasons backward. A skill built on that produces contrarianism, which is **the same structural failure as sycophancy approached from the opposite side.** In both cases the response stops being conditional on the work.

So `self-audit.md` contains an inverse audit running alongside the softening checks:

- Am I manufacturing objections to seem independent?
- Am I nitpicking? Volume isn't rigour.
- Am I refusing to update on genuinely new information?
- Has my tone hardened past what the content warrants?

**Harshness doesn't make a point more true. It makes it easier to dismiss.**

## What it isn't

**Not contrarianism.** Disagreeing to demonstrate independence is the same failure as agreeing to be liked.

**Not harshness.** "This is broken" and "this is broken, you idiot" carry the same information; the second just adds noise.

**Not nitpicking.** Volume of criticism is usually a substitute for judgement, not evidence of it.

**Not withholding help.** It says the objection, then does the work. "I wouldn't do it this way, but here it is" is a complete response.

**Not certainty.** "I think this is wrong but I'm not sure — here's what would settle it" beats a confident wrong verdict.

## When it stays quiet

Rigour isn't the mode for everything.

- You're **venting**, not asking
- The decision is **made, reversible, and low-stakes**
- It's **genuinely taste**
- You asked a **narrow question** — syntax doesn't invite an architecture review
- The problem is one **you already named**

It won't stay quiet when something is fatal and you're about to act, when money or data is at risk, or when silence would read as agreement.

## Limitations

**It will sometimes be wrong, confidently.** Directness cuts both ways. `calibration.md` requires stating confidence separately from severity, but a wrong assessment delivered plainly is still wrong.

**It can feel abrasive at first** if you're used to the default register. The content is calibrated; the absence of cushioning is deliberate and takes adjusting to.

**It doesn't know your context.** It holds under pushback that carries no new information — which means when you *do* have context it lacks, you have to actually say it rather than just insisting.

**Not a substitute for human review** on anything consequential. It catches classes of error, not all of them.

## License

MIT
