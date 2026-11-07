# Exact text to paste into the Google Sites editor

Google Sites exposes almost no SEO fields. These are the only three that matter,
plus the text tweaks that make the pages match what people search for.

---

## 1. Site name (Settings → the site name field)

Replaces `evoimogen`, which is currently the `<title>` of every page.

```
Evolutionary Immunogenetics — EvolBioMed group
```

If the field has a length limit, use:

```
Evolutionary Immunogenetics — EvolBioMed
```

## 2. Site description (Settings → Search engines → Site description)

Becomes the meta description Google shows under the link. ~150 characters.

```
Evolutionary immunogenetics group led by Bayazit Yunusbayev: how pathogen-driven selection shaped immune phenotypes, autoimmunity and TB susceptibility.
```

If the *Search engines* tab is not available in your account (it is offered only
for some Google Workspace accounts), skip it — the new site at `evobiomed.org`
carries a proper description anyway.

## 3. Home page — add above the current first paragraph

```
Official group website: evobiomed.org
```

Make `evobiomed.org` a hyperlink to `https://evobiomed.org`. Put it in a small
text box at the very top of the home page, not inside an image.

## 4. Home page — extend the intro (currently 2 paragraphs, ~330 words short)

Append this paragraph after the existing “Our team spans research groups at
Tartu University…” paragraph:

```
We work on three connected questions: how natural selection acting on immune
genes shaped present-day risk of autoimmune and inflammatory disease; how human
demographic history structured genetic variation across Eurasia; and which host
genetic and microbiome factors determine susceptibility to tuberculosis and the
outcome of treatment. The group combines population-genetic inference with
functional experiments on human immune cells and with deep metagenomic
sequencing of patient cohorts.
```

## 5. Home page — replace the news heading

`News` → `News and group updates`

## 6. Image alt text (Google Sites: click image → Alt text)

Currently every photo on the site has empty alt text, so search engines see
nothing. Suggested values:

| Page | Image | Alt text |
|---|---|---|
| Home | banner | `EvolBioMed group research banner` |
| Home | news photos | `Group members after MSc thesis defence, Saint Petersburg State University` |
| People | each portrait | `Portrait of <Full Name>, <role>` |
| Research | section images | `Illustration: <topic>` |

Decorative images can stay empty — only the portraits and the group photos
carry information.

## 7. Fix existing typos while you are in there

These are on the live page and are visible to visitors:

- `2025, Aprill,` → `April 2025 —`
- `2021-202 3,` → `2021–2023,`
- `June 18, 202 5,` → `18 June 2025,`
- `2023, C ongratulations` → `2023 — Congratulations`
- `Bayazit Yunusbayev, Phd` → `Bayazit Yunusbayev, PhD`
- `H is research integrates` → `His research integrates`
- `Al ena is interested` → `Alena is interested`
- `Ms thesis` → `MSc thesis` (throughout)

---

## Why the rest is not worth doing on Google Sites

- **No sitemap.** `sites.google.com/view/evobiomed/sitemap.xml` returns 404.
  Google Sites generates none.
- **No Search Console.** You cannot verify `sites.google.com/view/…` — no file
  upload, no DNS, no analytics tag. So no sitemap submission, no “Request
  indexing”, no indexing diagnostics.
- **No canonical, no per-page description, no control over `<title>` beyond the
  site name, no structured data.**
- **Weak domain signal.** `sites.google.com` is a shared host: your pages
  inherit none of the authority a dedicated domain accumulates, and Google
  crawls new `sites.google.com/view` paths conservatively.

That is why the fix is a real domain (`evobiomed.org`) plus backlinks, with the
Google Sites page kept as a labelled mirror.
