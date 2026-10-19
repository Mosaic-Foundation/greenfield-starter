#!/bin/bash
# Paste this into the cloud environment's "Setup script" field at claude.ai/code.
# It runs as root before Claude Code starts and must exit 0 within about 5 minutes, after which
# the environment is cached. Steps that fail are non-fatal (|| true) so a session still starts.

# Node 24 and npm 12.2.0, to match the Civic Hub, CI and Vercel. Cloud VMs ship Node 22.
# `n` downloads from nodejs.org (on the default allowed list) and installs to /usr/local/bin.
npm install -g n >/dev/null 2>&1 && n 24 >/dev/null 2>&1 || true
/usr/local/bin/npm install -g npm@12.2.0 >/dev/null 2>&1 || true

# Playwright's Chromium and its system libraries, so e2e tests don't download per session.
# Needs cdn.playwright.dev and playwright.download.prss.microsoft.com on the allowed list.
npx -y playwright@1.64.1 install --with-deps chromium >/dev/null 2>&1 || true

exit 0
