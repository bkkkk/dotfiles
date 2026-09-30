## Non-negotiables

* DONT EVER READ .envrc FILES EVER!
* NEVER ECHO ENVIRONMENT VARIABLES UNLESS EXPLICITLY TOLD TO BY ME

## Essential Commands

```sh
# These commands might not work in a git worktree
git finish  # Close off merged local branch. Use after PR is merged.
git feature # Set up a branch for a new feature.
git fix     # Set up a branch for fixing bugs.
git change  # Set up a branch for changes to existing features.

gh repo view --web # Open GitHub repo in browser
gh pr create       # Create a new PR from GitHub CLI
```

## Coding style

- Function names should always be verbs like get_X, write_X, increase_z, unless it's a class property or something like that.
- Function comments should always start with a verb like gets, calculates, removes, etc.
- Documentation of functions, arguments, etc, should describe only the current state. 
- Include historical context only to explain legacy code being kept around to for compatibility.

## Architecture Guiding Principles

* **Single Responsibility:** Avoid creating large classes with mixed purposes. Functions and classes should have only one reason to change.
* **Interface Segregation:** Functions should only depend on interfaces and methods that they need and are close to them in the system (Law of Demeter).

## Explanation and Teaching Guiding Principles

* Your responsibility is to teach me.
* Do not assume I know the details of the repository or topic.
* Use progressing information disclosure to explain a complex topic.

## On Committing

* Claude Code sessions sign commits with a dedicated agent key (`~/.ssh/agent_signing`). gitconfig setup for agents is done by setting `GIT_CONFIG_GLOBAL` to a dedicated gitconfig file.
* NEVER BYPASS COMMIT SIGNING! Do not pass `--no-gpg-sign` or `-c commit.gpgsign=false`. Do not override the signing key or the signing program.
* NEVER read, copy, or print the private key `~/.ssh/agent_signing`. You may read only the `.pub` file.
* If signing fails, stop and prompt me to commit myself.
* When a task is done and it's ready for me to review, commit it, push it, and create a PR (if it doesn't exist already). If I've asked you to keep going and complete multiple tasks, you can create a new branch/PR to do so.

## On working with task files

* Planning work: Generate markdown task files in the project under `<PROJECT_ROOT>/jay/docs/tasks/`. One file per task.
* After finishing a subtask: Mark it done.
* After finishing all subtasks in a task file: Delete it.
* The `jay/docs/tasks` folder should be git ignored in Panalyt projects.

## Writing Guiding Principles

* Adhere to ASD-STE100 style always.
* Be extremely concise. Sacrifice grammar for the sake of concision.
* NEVER end a sentence with a preposition.
* Avoid "land", "landed", "lands", "landing" as a metaphor for shipping, merging, or arriving. Say what actually happened: merged, shipped, released, written, set, resolved to, dated at.

## Git Guiding Principles

* Always use `git feature`, `git fix`, or `git change` unless working in a worktree. This won't work.
* If on an existing feature branch: Ask me if I want to build the new branch on top or branch from main.

# For Work at Panalyt

* Always prefix PR titles with the Linear ticket if there is one for example: `[PANA-131] Add metric PMG0512 (Overtime on weekend)`
* 1Password is a personal tool so not used to manage Panalyt secrets.

## PR descriptions Writing Principles

- Before drafting, identify the *why* for the change, the motivating problem/reason. If not obvious from the diff, commit history, or linked ticket, ask me for it rather than inferring — don't default to describing only *what* changed. Usually 1 paragraph will suffice. Use progressive information disclosure when explaining how objects and processes are related to each other.
- No narration or emojis.
- Imperative mood, terse: "Fix X", "Update Y", "Add Z" — no periods, no elaboration
- Prefer to refer to classes, concepts, and objects when describing interactions between code rather than specific files. So for example "The [export chain] was modified to include the newly migrate stage".
- Reference specific code/field identifiers in backticks `my_potato_func`.
- Always front-load the benefits/goals of the PR before going into details.
- Reviewers might not know what the module or system you edited do. Use progressive disclosure language to set the background.

- Always use the PR description template. Omit "This PR Also" list, or "Testing" Section if not relevant:

```markdown
This PR <adds the ability to/fixes an error whereby/changes the way in which X is done>...

This PR also:

<THIS SECTION IS FOR ADDITIONAL INCIDENTAL CHANGES NOT STRICTLY RELATED TO THE PRIMARY GOAL OF THE PR STATED ABOVE. FORMATTING FIXES, INCIDENTAL BUGFIXES THAT BLOCKED PROGRESS, ETC.>

* <LIST OF CHANGES, PREFER 1 SENTENCE; 2 AT A PUSH.>
* <ANOTHER CHANGE>

## Testing

* [x] <LIST OF TESTS THAT WERE EXECUTED OR NEED TO BE EXECUTED>
* [ ] <MANUAL TEST TO BE RUN BY USER>
```

### Specifics for Metrics

For PRs adding or editing metrics only.

- Name the specific IDs (`PMG0172`, `customFilter17`) in the initial why section, and briefly describe what it/they represent

### PR Description Examples

Example 1:

```
This PR makes the pipeline executable against any panacloud environment, which is critical to being able to migrate the library to work in the datapipeline DAG environment.

* Adds 2 environment configuration classes, GCS and Local, that help read and write data from/to the chosen environment.
* The GCP run environment name and target bucket are now inputs to the pipeline rather than being hardcoded. They can be provided to the SDK through the environment configuration classes directly, or through the JSON config files. The run environment name defines the table names in BigQuery, the project name used when building the BigQuery client , and the root of the output folder in GCS.
* The storage information has been added to the relevant client JSONs to maintain compatibility with the existing approach until we deprecated the CLI.

This PR also:

* Adds `jay/` to `.gitignore`

## Testing

* [x] `pytest tests` - 153 pass, plus new coverage for environment selection, `root` validation and a missing environment block
* [x] `hc-sim run sample` and `hc-sim qa sample` end to end
* [ ] A `panacloud-qa` client run, to confirm BigQuery and the bucket still resolve as before
```

Example 2:

```
This is part of the preparations for integration into the data platform.

## Background

The input data to the simulation is partially defined by a start and end year parameters in `RunConfig`. The range is static since the pipeline is only executed once. However once we migrate this system to run regularly, we need some mechanism to move that measurement window forward to consider newer and potentially more representative data.

## Changes

This PR replaces the static time-range in the configuration with a relative one. Instead of the static time-range, the callers are expected to define an optional `end_year` and `lookback_years` parameters which are used to calculate the time range from the available data. If `end_year` is not provided the pipeline defaults to the latest available year of data that contains the `target_month`.

This PR also adds a validation of the time-range to see if it's present in data. Prior to this the only check was if the dates were in the future. The rest of the pipeline ran and produced empty or partially wrong results.

Calculating and validating the time-range now involves a query of the data, so it's been moved out of `RunConfig` into `DataSource` (which is where all data querying happens). The time-range is calculated at the start of the pipeline and passed to all stages that need it.

QA report generation also reads the simulation time range from the data in the same way.

All client configurations were kept functionally the same, but now the range is based on the new relative definition. No client rolls forward until its `end_year` is removed once we integrate into the DAG.

Note: The pipeline will fail if any of the requested versionids are missing. It's possible, though unlikely, that the pipeline will no longer work for some clients in the configuration file if some of their data is incomplete. This is a data quality issue that wasn't caught.

This PR also:

* Simplifies the signatures of 3 methods in `DataSource`. They now take `domain`, `snapshot_dates`, and column lists instead of the RunConfig object. 
* Renames the `DataSource` functions to be verbs rather than nouns.
* Simplifies the signature of a number of functions that used to take a `RunConfig` object to now accept the primitives instead.

## Testing

* [x] `pytest tests` - 150 pass, including new coverage for the window builder, both resolution branches, a window past the data, a lookback before it, a `target_month` with no snapshot, and the `DISTINCT versionid` query
* [x] `hc-sim run sample` and `hc-sim qa sample` diffed against `export/sample/20260916` - 61 identical CSVs, both workbooks equal sheet-for-sheet, QA report identical
* [x] A sample run with `end_year` unset resolves the same 2022-2024 window and produces the same output
* [ ] A `gcs` client run, to confirm the resolved window matches the one its config names today
```