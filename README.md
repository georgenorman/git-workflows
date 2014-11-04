# Git Workflow Scenarios

All scenarios are written using a single user, but multiple users could have been included.

## Single Branch Workflow (SBWF)

Developers code using the master branch. The master branch is tagged
for each production release.

```bash
cd ~/Projects/git-workflows
./scripts/single-branch-workflow.sh
```


## Dual Branch Workflow (DBWF)

The development (master) branch contains the latest code that's under development.
Features and bug fixes are selectively merged, from the development branch, into the release branch.
The release branch is tagged for each production release.

```bash
cd ~/Projects/git-workflows
./scripts/dual-branch-workflow.sh
```


## Release-Stream Workflow with Feature Branches (RSWF)

Each release has its own stream of branches and multiple releases can be developed concurrently.
For example, multiple teams can be developing Release-1.0.0 and Release 1.1.0 concurrently.
A release stream consists of a series of branches for a particular release (e.g., "R-1.0.0-SNAPSHOT", "R-1.0.0-RC001", "R-1.0.0-RC002" and "R-1.0.0").

A release stream for Release-1.0.0 could be made up of a major snapshot branch, followed by a couple minor release candidate branches and culminating in 
the final release branch (which would be deployed to production). The release stream for R-1.1.0 could be very similar and could occur concurrently 
with R-1.0.0, as illustrated below:

```
[R-1.0.0-SNAPSHOT] --> [R-1.0.0-RC001] --> [R-1.0.0-RC002] --> [R-1.0.0]

[R-1.1.0-SNAPSHOT] --> [R-1.1.0-RC001] --> [R-1.1.0]
```

Each of the branches above can be developed using multiple feature and bug-fix branches. For example, the [R-1.0.0-SNAPSHOT] branch could be
driven by branches represented by Feature-003, Feature-007 and BugFix-101, as shown below:

```
   [Feature-003]   [Feature-007]   [BugFix-101]
                \        |         /
                 [R-1.0.0-SNAPSHOT]
```

```bash
cd ~/Projects/git-workflows
./scripts/release-stream-workflow.sh
```
