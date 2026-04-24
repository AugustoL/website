# Production files for AugustoL/website

These three files replace `index.html` + `styles.css` in your repo and add a new `script.js`.
No build step, no React, no dependencies beyond what you already ship (Bootstrap + FontAwesome + Lato).

## What to commit

Drop these into the repo root:

```
index.html   ← replace existing
styles.css   ← replace existing
script.js    ← new file
```

Your existing folders stay as-is:
- `assets/` — trex.jpg, background.png, handWhite.ico, handRed.ico, CV PDFs, PGP key
- `vendor/` — lato.css, bootstrap.min.css, fontawesome.min.js
- `.well-known/`
- `bundle.sh`

## Things to edit before deploying

1. **Your ETH address** in `index.html`: search for `0xA1C4...7E29` and replace with your real address (or remove the `.ens-addr` span if you only want `augustol.eth`).
2. **Project links** — currently point to:
   - `https://github.com/openscan-explorer/explorer`
   - `https://github.com/AugustoL/erc20-flash-lender`
   Swap if you'd rather link to a website or docs.

## Git steps

```bash
cd /path/to/website
# back up current versions (optional)
cp index.html index.html.bak
cp styles.css styles.css.bak

# copy the new files from this export over the originals
# then:
git add index.html styles.css script.js
git commit -m "Redesign: add about / portfolio / CV sections"
git push
```

Your `bundle.sh` and IPFS deploy flow should continue to work unchanged.
