# Finding What's Actually Wrong

Method, by domain. Ordered so the expensive errors surface first.

---

## The universal order

1. **Premise** — is the question wrong?
2. **Correctness** — does it work? are the facts right?
3. **Failure modes** — what breaks it?
4. **Omissions** — what's missing that changes the conclusion?
5. **Confidence** — are they more certain than the evidence supports?
6. **Craft** — structure, clarity, maintainability

**Never invert this.** Craft findings on a fatally-flawed premise are wasted work for both of you.

---

## The premise check

The one most often skipped, and the one that most often matters.

**Ask:**
- Does this solve the problem they actually have?
- Is the thing they're optimising the thing that's limiting?
- Are they treating a symptom?
- Would succeeding at this help?

**Examples:**

| They asked | The real issue might be |
|---|---|
| "How do I make this query faster?" | The query is fine; there's no index |
| "How do I get more signups?" | Signups are fine; retention isn't |
| "Which framework should I use?" | Framework choice isn't the bottleneck |
| "How do I handle 10k concurrent users?" | You have 40 users |
| "How do I convince my team?" | The team may be right |

**How to raise it without being presumptuous:** answer what they asked, then add the reframe in a line or two. They may have already considered and rejected it — the framing should leave room for that.

> "Here's the optimised query. Separately — a seq scan over 2M rows suggests there's no index on `(customer_id, created_at)`. That's likely the actual 4s, and the query rewrite is worth maybe 200ms of it."

---

## Code

**Correctness**
- Run it, or trace a concrete input
- Empty, null, single-element, boundary, very large
- Off-by-one at both ends
- Type coercion at boundaries
- Errors surfaced or silently swallowed

**Security**
- Input validated at the trust boundary
- String-built SQL
- Secrets in source
- Authorisation checked where the resource requires it
- Deserialisation of untrusted data

**Concurrency**
- Shared mutable state
- Check-then-act races
- Non-atomic compound operations
- Locks acquired in different orders

**Failure**
- What happens when the dependency is down?
- Retry logic that amplifies rather than absorbs
- Timeouts present
- Partial-failure states

**Data**
- Migrations reversible
- Destructive operations ordered safely
- Nullable columns handled

**Craft, last**
- Fits the codebase's conventions
- Function size, nesting depth
- Names that say what the thing is

---

## Writing

**Premise** — does the piece do the job it's for? A persuasive brief structured as an informative one persuades nobody.

**Structure** — first sentences of each paragraph, read in sequence. Do they tell the story? If not, the structure is wrong and no line editing fixes it.

**Claims** — anything asserted without support. Numbers with no source. Confident statements about contested things.

**Specificity** — sentences that could appear in someone else's document about something else. That's the tell for filler.

**Audience** — right register, right assumed knowledge, right length for who reads it.

**Craft** — hedging, nominalisation, padding phrases, uniform sentence length.

---

## Plans and strategy

**The binding constraint** — is the plan optimising the thing that's actually limiting? Most plans optimise the comfortable constraint rather than the real one.

**The riskiest assumption** — what does everything rest on? Is it tested first, or step six? Discovering a false assumption after five completed steps wastes all five.

**Sequencing** — dependencies respected? Anything on the critical path that could be parallel?

**The good-case-only plan** — what happens when a step fails? Is there a checkpoint? What signal means stop?

**Concreteness** — "improve onboarding" isn't a plan. "Cut signup from 5 fields to 2 by Friday" is.

**Exclusions** — is it clear what's *not* being done? Scope creep is silent until it isn't.

---

## Analysis and data

**Data quality first, always.** Most wrong analyses are wrong because of the data, not the method. Duplicated joins, silent nulls, wrong grain, filtered-out rows.

**Correlation presented as causation.** Especially when the causal story is appealing.

**Cherry-picked window.** Any trend reverses with the right date range. Is the range justified or convenient?

**Sample size.** Is the change outside what random variation produces anyway? 3 conversions to 5 is not a 67% improvement.

**Survivorship.** Studying only what remains. The churned customers usually hold the answer.

**Simpson's paradox.** Aggregate trend reversing within every subgroup. Segment before concluding.

**False precision.** Decimal places the data can't support.

**The missing comparison.** A number with no baseline means nothing.

---

## Decisions

**Options** — is "do nothing" on the list? It's frequently right and almost always omitted.

**Criteria** — set before or after seeing the options? After is where motivated reasoning enters.

**Reversibility** — is this one-way? If so, is the analysis proportionate?

**The unstated assumption** — what has to be true for this to be right?

**Who benefits** — is the recommendation shaped by whose it is?

---

## Arguments

**The load-bearing premise** — which claim, if false, collapses the argument? Is it supported?

**Equivocation** — a term used two different ways across the argument.

**Missing counter-argument** — is the strongest opposing case addressed, or a weak version of it?

**Circularity** — the conclusion smuggled into the premises.

**Conflated correlation and cause.**

**False dichotomy** — two options presented where more exist.

---

## What "no findings" looks like

Sometimes there's nothing serious. Say so, briefly, and specifically enough to be credible:

> "Nothing serious. The retry logic handles the backoff correctly and the error paths all propagate. Two preference-level things I'd have done differently, but they're not worth changing."

**Do not manufacture a finding to seem rigorous.** A clean review from a reviewer who criticises when warranted is genuinely informative. A clean review from one who never criticises is not — which is exactly why the criticism has to be real when it comes.

**Being specific about what you checked** is what makes "nothing serious" credible. "Looks good!" is not a review.
