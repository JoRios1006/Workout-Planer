# Workout Planner

Workout Planner is a command-line application written in Julia to help you manage and track your workout routines. It allows you to add, remove, and edit exercises and muscle groups, calculate one-rep max, and save/load your workout routines to/from a file.

### Features:

-   Add an exercise and its associated muscle group
-   Remove an exercise and its associated muscle group
-   Edit an exercise and its associated muscle group
-   Calculate one-rep max based on weight and reps
-   Save your workout routine to a file
-   Load a workout routine from a file
-   Add today's workout
-   View today's workout

### Dependencies:

-   REPL
-   REPL.TerminalMenus
-   Match

### How to use:

1. Install Julia programming language if you haven't already: https://julialang.org/downloads/
2. Clone this repository or download the `workout.jl` file
3. Open a terminal/command prompt and navigate to the directory containing the `workout.jl` file
4. Run the program using the following command:

```
julia workout.jl
```

5. Follow the on-screen prompts to manage your workout routines.

### File format for saved workouts:

Workouts are saved in an org-mode style format:

```markdown
#+TITLE: Workouts

## Chest

-   Bench Press
-   Dumbbell Fly

## Back

...
```

### Known issues / TODO:

-   Add a way to save the items to a file
-   Add a way to load the items from a file
-   Group exercises by muscle group
-   Fix the bug: LoadError: UndefVarError: muscle_group not defined

### License

This project is open-source and available under the MIT License.
