# General Rules

## On Committing

* We use 1Password for SSH/GPG signing credentials and it requires my fingerprint to authenticate. If that fails, stop and prompt me to commit myself.
* NEVER BYPASS GPG SIGNING OF COMMITS!
* When you're done with a task, always commit and push (if there's a remote).

## On working with task files

* When planning work generate tasks and store them in a markdown file in the project under `docs/tasks/name_of_development_phase.md`
* When working with a task file, and implementation is done and confirmed working, make sure to mark the task done before committing and pushing code changes.

## On Diagramming 

* When building a new app interaction or updating an existing core interaction create a sequence diagram explaining the process from the initiator (whether it's a person or a service) to the app or user in question.
* Add the diagram to either the README.md file if it exists, an docs/ARCHITECTURE.md which you can create, or the the CLAUDE.md file in the project.

# For Work at Panalyt

* Always prefix PR titles with the linear ticket if there is one for example: `[PANA-131] Add metric PMG0512 (Overtime on weekend)`
* When creating a PR follow either the short or long template depending on how big the change is:

- Long Template
```
# Background

<SOME DESCRIPTION OF THE PROBLEM BEING SOLVED IN THIS PR>

# Description

<DESCRIPTION OF MAIN CHANGE MADE IN THIS PR TO ADD REQUESTED FEATURE OR RESOLVE BUG OR ISSUE>
```

- Short Template
```
This PR <adds the ability to/fixes an error whereby/changes the way in which X is done>...
```

* Always highlight unrelated changes bundled in the PR separately from the main change as follows:

```
This PR also:
* Adds this unrelated change to improve/fix X
```