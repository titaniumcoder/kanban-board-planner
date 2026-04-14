# Kanban Board Planner

The goal of this project is to build a Kanban board planner. Here are the planned milestones:

## Milestone 1

Read and visualize GitHub issues on the board, then synchronize progress back to GitHub. Use LiveView
to synchronize updates and use webhooks to receive changes from GitHub, resulting in live updates.

## Milestone 2

Track which users have which skills based on closed tickets, and automatically suggest who should take
which TODO tasks. Show when a ticket is blocked by another ticket, while still allowing user overrides.

## Milestone 3

Allow users to edit their skills (for example, moving from backend-focused work to frontend-focused work).

## Milestone 4

Allow users to organize the backlog. Add estimates and validate estimates against existing tickets.
Detect issues that likely mix multiple concerns and should be split. Validate whether a ticket follows
defined specs and standards.

## Milestone 5

Integrate Planning Poker into this app and highlight large gaps between current estimates and past estimates.

# Documentation and Technology

This is a demonstration project. Phoenix is used to keep development focused on AI-related features.

Available documents:

- [docs/development.md](./docs/development.md) - local development setup and environment notes.
- [docs/ai.md](./docs/ai.md) - local AI setup documentation.
