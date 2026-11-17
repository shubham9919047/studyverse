# STUDYVERSE — prototype

This is a responsive, clickable front-end prototype for the STUDYVERSE learning platform.

## Run locally
1. Extract the ZIP.
2. Open `index.html` in a modern browser.

No installation or API key is needed for this prototype.

## Included demo sections
- Dashboard and student overview
- Class and exam tracks (Class 5–12, JEE, NEET, NDA, CUET, UPSC, others)
- Sample quiz interaction
- Study games preview
- Demo leaderboard
- Safety-first study community preview
- Official exam portal links
- Progress and motivation sections
- Mobile-responsive layout

## Important: prototype vs production
This package is a front-end prototype. It does **not** yet provide real account registration, server-side database, verified PYQ library, live ranking, real-time chat, push notifications, or automatic exam-date monitoring. Demo scores and sample questions are not real student records or an official PYQ archive.

## Recommended production architecture
- Next.js + TypeScript for the web app
- Supabase Auth + PostgreSQL + Row Level Security for accounts and data
- Server-side role checks for student, moderator and admin
- Moderated topic-based rooms; disable unsolicited private messages for younger users
- Consent and age-appropriate onboarding, data minimization, reporting/blocking, rate limits and moderation queue
- Admin-reviewed exam notices with official source URL, verification timestamp and expiry
- Versioned question bank with exam, year, subject, topic, difficulty, answer and explanation metadata
- Cohort-based rankings (same class/exam), anti-cheating controls and transparent scoring rules

## Suggested build phases
1. Identity, onboarding, class/exam selection and profile
2. Question bank, tests, explanations and progress analytics
3. Leaderboards, badges, daily tasks and games
4. Moderated study rooms and messaging
5. Admin CMS, exam calendar, notifications and official-source verification
6. Security review, accessibility, privacy review and deployment

Never put Supabase service-role keys or other secrets in browser code. Configure them only on a trusted server.
