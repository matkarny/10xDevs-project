# 10x-cards

> Rapidly create and manage educational flashcards using AI and spaced repetition.

## Table of Contents
1. [Project Name](#project-name)  
2. [Project Description](#project-description)  
3. [Tech Stack](#tech-stack)  
4. [Getting Started Locally](#getting-started-locally)  
5. [Available Scripts](#available-scripts)  
6. [Project Scope](#project-scope)  
7. [Project Status](#project-status)  
8. [License](#license)  

## Project Name
10x-cards

## Project Description
10x-cards is a web application that streamlines flashcard creation for learners. By leveraging large language models (via Openrouter.ai), it auto-generates question-and-answer pairs from user-provided text. Users can review, edit, and save cards, then study them using a spaced repetition algorithm—all within a secure, scalable environment.

For full requirements, see [PRD](.ai/prd.md).

## Tech Stack
- **Frontend**: Astro 5, React 19, TypeScript 5  
- **Styling**: Tailwind CSS 4, Shadcn/ui  
- **Backend**: Supabase (PostgreSQL, Auth, BaaS)  
- **AI**: Openrouter.ai (multi-model API routing, cost limits)  
- **CI/CD**: GitHub Actions  
- **Hosting**: DigitalOcean (Docker)

## Getting Started Locally

### Prerequisites
- Node.js v22.14.0 (see `.nvmrc`)  
- npm (or yarn)

### Installation
```bash
# Clone the repo
git clone https://github.com/matkarny/10xDevs-project
cd 10xDevs-project

# Install dependencies
npm install
```

### Environment Variables
Create a `.env` file in the project root with:
```env
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
OPENROUTER_API_KEY=your_openrouter_key
```

### Run Locally
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000).

## Available Scripts
In `package.json`:
- `npm run dev`       – start development server  
- `npm run build`     – build for production  
- `npm run preview`   – preview production build  
- `npm run astro`     – Astro CLI  
- `npm run lint`      – run ESLint  
- `npm run lint:fix`  – auto-fix ESLint issues  
- `npm run format`    – run Prettier

## Project Scope

### In Scope (MVP)
- AI-powered flashcard generation (accept/edit/reject)  
- Manual flashcard create/edit/delete  
- User authentication & account management  
- Spaced repetition integration  
- Data storage in Supabase  
- Basic generation metrics

### Out of Scope
- Custom repetition algorithm  
- Gamification  
- Mobile applications  
- Document imports (PDF, DOCX)  
- Public API  
- Flashcard sharing  
- Advanced notifications or search

## Project Status
This project is in active development (MVP phase). See [issues](https://github.com/matkarny/10xDevs-project) for progress.

## License
This project is licensed under the MIT License.