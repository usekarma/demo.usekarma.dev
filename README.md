# demo.usekarma.dev

Static frontend for **https://demo.usekarma.dev**, including:

## Overview

This repository hosts the static assets served at **demo.usekarma.dev**,
providing: - A **demo web application** used for ClickHouse (CH)
Proof‑of‑Concept UI experiments. - A standalone **global logout-all
page** (`logout-all.html`) that performs fan-out logout across all
`*.usekarma.dev` applications such as Grafana, ClickHouse, and
Prometheus.

Everything in this repo is bundled and deployed as a static website via
the **`serverless-site`** Adage component. The site is delivered through
S3 + CloudFront and requires no backend code in this repository.

## Features

### 🔹 Demo Web Application

A lightweight front-end UI designed for: - Integrating with backend APIs
hosted at `demo-api.usekarma.dev` - Displaying PoC results and
ClickHouse-driven dashboards or interactions - Testing future Cognito +
Amplify login flows - Demonstrating usekarma/adage patterns in a real
browser application

The app is built as a standard **SPA (React/Vite or plain JS)** and
compiled to static assets located in `dist/`.![alt text](../usekarma.dev/static/assets/logo/favicon-light.png)
![alt text](../usekarma.dev/static/assets/logo/favicon-light.png)![alt text](../usekarma.dev/static/assets/logo/favicon-light.png)
### 🔹 Global Logout-All Page

A dedicated HTML page (`logout-all.html`) that: - Logs the user out of
**Cognito Hosted UI** - Clears **ALB sessions**\
- Sends logout requests to all participating `*.usekarma.dev` apps so
their cookies and sessions are invalidated

This is the only reliable way to achieve **"logout from everywhere"** in
a multi‑app ecosystem using Cognito + ALB authentication.

### 🔹 Runtime Configuration

The demo webapp can load dynamic values---such as: - API base URL
(`demo-api.usekarma.dev`) - Cognito configuration - Environment settings
![/home/ted/dev/usekarma.dev/static/assets/logo/favicon-light.png](../usekarma.dev/static/assets/logo/favicon-light.png)
...from a **`/config/runtime.json`** file placed into the S3 bucket by
backend infrastructure (`serverless-api`).

This keeps the UI environment‑aware without requiring a rebuild.

## Repository Structure

    demo.usekarma.dev/
    ├── public/
    │   ├── logout-all.html      # standalone fan-out logout page
    │   └── favicon.ico
    ├── src/
    │   ├── main.tsx / main.js   # app entrypoint
    │   ├── App.tsx / App.js     # root UI component
    │   ├── pages/               # SPA routes/views
    │   ├── components/          # shared UI components
    │   ├── config/
    │   │   └── runtime.ts       # logic to fetch /config/runtime.json
    │   └── styles/              # CSS / styling
    ├── scripts/                 # optional: build/deploy helpers
    ├── dist/                    # build output (generated, gitignored)
    ├── package.json
    └── README.md

## Deployment

This repository is deployed entirely by the `serverless-site` component
in `aws-iac`:

1.  Run `npm run build` to generate the `dist/` folder
2.  Sync the output to the S3 bucket created by `serverless-site`
3.  CloudFront distributes the site globally at
    **https://demo.usekarma.dev**

Backend APIs and Cognito integration can be added later without
modifying this repository.

## Purpose

This repo serves as the front door for demos, PoCs, and interactive UI
experiments within the **usekarma.dev** ecosystem. It cleanly
separates: - **Frontend assets** - **Backend API infrastructure** -
**Authentication and logout orchestration**

while remaining simple and easy to evolve.
