# Registered Antennas Scraper (keraies.eett.gr) v2

Enhanced version of the `keraies` actor. Two-stage scraper of Greece's
registered antenna registry at keraies.eett.gr:

1. **Stage 1** — for each municipality, page through the search results and
   collect unique antenna IDs + basic data (serial, code, category, company,
   address, municipality).
2. **Stage 2** — fetch full details per antenna (position code, region,
   WGS84 coordinates, permit status, measurements, documents) and push to the
   dataset in batches.

## v2 changes

- Input schema actually used: `municipalities`, `max_antennas` (cost cap),
  `max_concurrency`, `request_delay_seconds`
- Stage 2 is now concurrency-limited (semaphore) instead of strictly sequential
- Pay-per-event monetization: each pushed antenna charges `antenna_scraped`
  (`Actor.push_data(..., charged_event_name='antenna_scraped')`)
- Proper actor.json (name `keraies-v2`, version 2.0), output + dataset schemas
- Removed backup/ORIGINAL file clutter

## Pricing (pay per event)

`antenna_scraped` (primary) — **$0.005 per antenna**.

## Run locally

```bash
pip install -r requirements.txt
apify run
```

## Deploy

```bash
apify push
```
