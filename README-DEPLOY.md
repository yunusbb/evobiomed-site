# evobiomed.org — deployment and discoverability playbook

This folder is a complete, static site (no build step). It is designed so that
Google can crawl, index and rank it — which the current Google Sites page
(`sites.google.com/view/evobiomed/`) cannot be made to do.

Everything below is in order. Steps 1–5 get the site live; steps 6–8 make it
*discoverable*; step 9 fixes the Google Sites page that stays online.

---

## 0. What is already done in this folder

| File | Purpose |
|---|---|
| `index.html`, `research.html`, `people.html`, `publications.html`, `resources.html` | The site. Semantic HTML, one `<h1>` per page, descriptive real text. |
| `404.html` | Custom error page (`noindex`). |
| `assets/style.css` | Stylesheet. No external fonts, no JS, nothing to block crawlers. |
| `assets/img/*` | Photos resized for web (76 KB–265 KB each, `width`/`height` set to prevent layout shift). |
| `sitemap.xml` | 5 URLs with `lastmod`. Required for fast indexing. |
| `robots.txt` | Allows everything and points to the sitemap. |
| `CNAME` | `evobiomed.org` (used by GitHub Pages). |
| `.nojekyll` | Stops GitHub Pages from running Jekyll and mangling paths. |

Every page carries: unique `<title>` (46–66 chars), unique meta description
(144–169 chars), `rel=canonical`, Open Graph + Twitter card, and JSON-LD
structured data (`ResearchOrganization` with founder, locations and
`sameAs`; `Person` list on People; `ScholarlyArticle` list with DOIs on
Publications).

Verified locally: all pages return 200, zero broken internal links or assets,
`sitemap.xml` parses against the sitemaps.org namespace, all JSON-LD parses.

---

## 1. Buy the domain

`evobiomed.org` was **available** at the time of writing (RDAP check).
`.com/about` is taken by an unrelated Swiss company, `Evobiomed Sàrl` — using
`.org` avoids that collision entirely.

Buy from Cloudflare Registrar (at-cost, ~$10/yr, free DNS), Namecheap or Gandi.
You only need the domain; hosting below is free.

## 2. Put the site on GitHub Pages (free)

`deploy.sh` in this folder does the git work and tells you the exact next step.

```bash
cd site/
./deploy.sh            # initialises the repo and commits
```

Then create an **empty public** repo named `evobiomed-site` at
<https://github.com/new> (no README, no .gitignore, no licence — files exist
already), and run once:

```bash
./deploy.sh git@github.com:<your-username>/evobiomed-site.git
```

After that, `./deploy.sh` alone commits and pushes every change.

Then on GitHub: **Settings → Pages → Source: Deploy from a branch → main / (root)**.
The site is live at `https://<your-username>.github.io/evobiomed-site/` immediately.

All internal links are **relative**, so the site works unchanged both in that
subdirectory and at the domain root. (Verified: every page, asset, the sitemap
and robots.txt return 200 from a subdirectory.)

## 3. Point the domain at GitHub Pages

**Settings → Pages → Custom domain** → enter `evobiomed.org` → Save.
GitHub writes the `CNAME` file (it already exists here, matching).

At your DNS provider, for the apex `evobiomed.org`:

| Type | Name | Value |
|---|---|---|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | `<your-username>.github.io` |

If your provider supports `ALIAS`/`ANAME` at the apex, use it instead of the four A records.
DNS propagates in minutes to a few hours. Then tick **Enforce HTTPS** (the
certificate is issued automatically once DNS resolves).

## 4. Check the live site before submitting it anywhere

Run the audit script from the folder above `site/` (it checks titles,
descriptions, h1s, canonicals, JSON-LD, every internal link, the sitemap and
robots):

```bash
cd ..
python3 check_site.py https://evobiomed.org
```

Expected output ends with `=== PROBLEMS === none`. Also:

```bash
curl -sI https://evobiomed.org/                # expect HTTP/2 200
curl -s  https://evobiomed.org/robots.txt      # expect the Sitemap: line
curl -s  https://evobiomed.org/sitemap.xml | head -20
```

Open `https://evobiomed.org/nonexistent` — you should get the 404 page.

## 5. Google Search Console — the part Google Sites made impossible

This is the single step you could never complete before: **you cannot verify
ownership of `sites.google.com/view/...`** (no HTML upload, no DNS, no
analytics tag), so you could never submit a sitemap or request indexing.
On your own domain you can.

1. <https://search.google.com/search-console> → **Add property → Domain** →
   `evobiomed.org`.
2. Verify with the DNS TXT record it gives you (`google-site-verification=…`)
   at your DNS provider. *(Alternative: URL-prefix property verified by
   uploading the `google….html` file to this folder — you already have one from
   an earlier attempt, but use the file GSC issues for the new property.)*
3. **Sitemaps → Add new sitemap →** `sitemap.xml` → Submit. Status should
   become “Success” within a day.
4. **URL Inspection** → paste `https://evobiomed.org/` → **Request indexing**.
   Repeat for `publications.html` (the page most likely to attract citation
   traffic). Don't request more than a few pages a day.

**Bing Webmaster Tools** (<https://www.bing.com/webmasters>) → *Import from
Google Search Console* (one click, imports verification and sitemap).
**Yandex Webmaster** matters for your Russian audience — add the domain there
too and submit the same sitemap.

## 6. Backlinks — this is what actually made you invisible

A search for the exact URL `sites.google.com/view/evobiomed` returns **zero
results on the indexed web**. No page links to it, so crawlers had no path to
discover it. A sitemap fixes discovery *after* Google knows the domain exists;
links are what create that first path. Do these this week, in this order:

| Where | What to do |
|---|---|
| **Google Scholar profile** | Add `https://evobiomed.org` in the *Homepage* field (Edit profile → Homepage). scholar.google.com is crawled constantly — this is the highest-value single link you can add. |
| **ORCID** | Add the URL under *Websites & social links* on your record. |
| **ResearchGate** | Add it as your lab/institution website. |
| **LinkedIn** | Add a “Website” link on your profile. |
| **SPbSU department page** | Ask the Department of Genetics and Biotechnology to link the group site from the staff page. A university link is a strong signal. |
| **ITMO / SCAMT page** | Same for the SCAMT Institute group listing. |
| **cGEM / University of Tartu** | Ask to be listed on the cGEM members page with the URL. |
| **GitHub** | Put the URL in the repo's “Website” field and in your profile README. |
| **Twitter/X, Mastodon, Bluesky** | Add to bio; post once about the group. |
| **Each new paper** | In the “Data availability” or affiliation line, cite `evobiomed.org`. |
| **Bashkir State Medical University** | Optional partner listing. |

Ten links from real institutional profiles is worth more than any on-page
tuning. Do not buy links or use link farms.

## 7. What to expect, in weeks

Search engines do not index on command — these are realistic windows:

- **1–3 days** — domain resolves, HTTPS active, GSC shows the property.
- **3–7 days** — sitemap “Success”; first crawl of the homepage.
- **1–3 weeks** — `site:evobiomed.org` starts returning pages; branded queries
  (*“EvolBioMed”, “Yunusbayev lab”*) start resolving.
- **1–3 months** — non-branded queries (*“evolutionary immunogenetics group”*,
  *“tuberculosis gut microbiome Russia”*) begin to rank, if backlinks exist.
- Google Sites pages, by contrast, can sit undiscovered for months — which is
  exactly what happened here.

Check progress with `site:evobiomed.org` in Google and
*Indexing → Pages* in Search Console. Do not re-submit the sitemap daily; it
slows nothing down and tells you nothing new.

## 8. Updating the site later

Edit the HTML in place, then:

```bash
git add -A && git commit -m "update publications" && git push
```

Actions redeploys in under a minute. When you add a page, add it to
`sitemap.xml` and to the `<nav>` on every page. Bump `<lastmod>` for the page
you changed. In Search Console, *URL Inspection → Request indexing* the
changed URL.

## 9. The Google Sites page — keep it, but label it

You asked to keep `sites.google.com/view/evobiomed/` live. Do these three
things in the editor (gear icon → *Settings*, and the page itself), because
its current `<title>` is the single word `evoimogen`, which nobody will ever
search for, and it has no meta description on any of its 5 pages:

1. **Settings → Search engines** (if your account offers it) → *Site
   description*: paste the text in `GOOGLE-SITES-COPY.md`.
2. **Site name**: `Evolutionary Immunogenetics — EvolBioMed` (this is what
   becomes every page's `<title>`; currently `evoimogen`).
3. On the home page, add one line at the top: *“This is our old site. The
   current group website is **evobiomed.org**”* with a link, and add the same
   link to the home page body.

That way the Google Sites page funnels visitors (and any crawler that does
find it) to the canonical site instead of competing with it.

---

## Content notes to check before you publish

I transcribed these from your existing Google Sites pages. Please confirm:

- **Alumni cards** — Darya Terentyeva “PhD student in Tübingen, Germany” and
  Grigory Sergeev “researcher at Alkor Bio Group, Moscow” come from role/city
  labels on your People page; I attached them to the right people inferring
  from the bios. Verify before publishing.
- **Milyausha Yunusbaeva** is listed as *Senior researcher* — your page only
  says “PhD”. Adjust the label if wrong.
- **Anastasia Kislova** is listed as *MSc student* with a note that she defended
  in June 2025 — change to *MSc* / *PhD student* as appropriate.
- **Founding date** in the JSON-LD is set to `2019` (your earliest group paper
  with the St Petersburg affiliation). Change if the group started earlier.
- The **PLOS Genetics** paper linked under “Human population genetics” is
  cited as background, not as a group output of that section — keep or drop.
