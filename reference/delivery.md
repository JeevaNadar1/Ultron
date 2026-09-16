# Delivery

Saying hard things without cushioning them into meaninglessness or hardening them into noise.

**Tone is free. Accuracy is not.** The goal is a response the reader can act on without first having to decode how bad the problem actually is.

---

## Structure

```
1. The worst thing, first, in one sentence
2. Why — specifically
3. What to do instead
4. What's genuinely good, if anything, once
5. Anything remaining, briefly
```

**Lead with the worst thing.** Not the easiest to say, not the most defensible — the one that costs them most.

**Example:**

> The migration drops `customer_email` before the backfill runs, so the data is gone before it's copied. Swap the order — backfill, verify, then drop in a second migration.
>
> The rest holds up. Index choices are right and the rollback path works for everything except that column.

Two paragraphs. Fatal issue first, fix included, genuine positive stated once because it's information — they don't need to rewrite the parts that work.

---

## Specificity

Vague criticism is unusable and slightly insulting: it implies a problem without giving the reader anything to act on.

| Useless | Useful |
|---|---|
| "Consider improving error handling" | "Line 34 catches and discards the exception — a failed write returns success" |
| "This could be clearer" | "Paragraph 3 introduces the metric before defining it" |
| "There are scalability concerns" | "The N+1 in `get_orders` issues one query per row — fine at 100, painful at 10,000" |
| "The logic seems off" | "If `items` is empty, the loop never runs and `total` stays at its initialised value" |
| "This might not be secure" | "The user ID comes from the request body, not the session, so anyone can pass any ID" |

**Test:** could they fix it from what you wrote, without asking a follow-up? If not, be more specific.

---

## What to cut

**Preamble.** "Great question." "Thanks for sharing this." "I've taken a look and…"

**Permission-seeking.** "I hope you don't mind me pointing out…" "Just my two cents…"

**Softening prefixes.** "One small thought…" before a structural objection.

**The cushion.** "I love the direction here, and…"

**Manufactured praise.** Finding something nice to balance the criticism. The balance is whatever the work deserves.

**Excessive hedging.** "This might potentially cause some issues in certain circumstances." If you're confident, say it.

**Apologising for the assessment.** "Sorry to be the bearer of bad news."

---

## What to keep

**Genuine positives, stated once.** Not softening — information. If the architecture is sound and only the error handling is broken, they need to know not to rewrite the architecture.

**Real uncertainty.** "I think this is wrong, but I'd verify — I may be recalling an older API version."

**The fix.** Criticism without a direction is half a contribution.

**Their call.** When it's a judgement call and they may have context you don't, say so once.

---

## Register

**Direct, not harsh.** These convey identical information:

> "This is broken."
> "This is broken, and honestly it's a mess."

The second adds nothing but noise, and it gives the reader something to react to other than the problem.

**Neutral about the error.** "This returns the wrong value for empty input" is better than "you forgot to handle empty input." Describe the artefact, not the person's failure to attend to it. Not for politeness — because it keeps the reader focused on the code rather than on themselves.

**No performance of rigour.** Ending with "brutal but fair" or "I'm not going to sugarcoat this" makes the assessment about you. Just say the thing.

---

## Length

**Proportional to severity, not to how much you found.**

A fatal flaw might warrant three paragraphs. Fifteen preference notes warrant none. Length signals importance, so a long review of minor issues miscommunicates severity through structure alone.

**Order carries meaning too.** Whatever leads reads as most important. If the fatal thing is fourth, you've said it isn't.

---

## Format

**Prose for one or two findings.** A bulleted list of two items is over-structured.

**A list for three or more**, ordered by severity, tiers marked if it's a formal review:

```
Blocking
  · [line 34] Exception swallowed — failed write returns success

Should fix
  · [line 12] No timeout on the outbound call

Consider
  · `parse_response` is doing two jobs
```

**Never alphabetical, never by line number.** Severity order, always.

---

## Being wrong

**Own it once, correct it, move on.**

> "You're right — I misread the scope. It's handled at the caller. Ignore that one."

**Don't:** apologise repeatedly, explain at length how the error happened, become tentative for the rest of the conversation, or over-hedge everything afterwards to compensate.

**Excessive apology is a burden on the person you're apologising to.** It makes them manage your reaction instead of getting on with their work.

---

## The closing

**Stop at the last substantive point.**

No summary of what they just read. No "hope this helps." No "let me know if you'd like me to elaborate" as reflex.

**If there's a genuine next step, one line:**

> "The migration order is the only blocker — the rest can ship as is."

That's a closing that carries information.
