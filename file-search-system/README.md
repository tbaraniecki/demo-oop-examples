# File Search System

OOP kata implementing a composable file search over a virtual file system using predicates and operators.

## Overview

A depth-first search traversal over a tree of `File` nodes. Search logic is expressed as a composable predicate tree, and attribute comparisons are delegated to pluggable operator objects.

## Design

### File tree

`File` represents a node — either a file or a directory. Directories hold child entries. `FileSearch` traverses the tree using an explicit stack and collects nodes that match a given criteria.

### Criteria and predicates

`FileSearchCriteria` wraps a predicate and is the entry point for search logic. Predicates implement a single method: `matches?(file)`.

| Class | Role |
|---|---|
| `SimplePredicate` | Matches a single file attribute against an expected value using an operator |
| `AndPredicate` | Passes only if all child predicates match |
| `OrPredicate` | Passes if any child predicate matches |
| `NotPredicate` | Passes if no child predicate matches |

`AndPredicate`, `OrPredicate`, and `NotPredicate` all inherit from `CompositePredicate` and accept an array of child predicates, allowing arbitrary nesting.

### Operators

Operators handle the actual value comparison inside `SimplePredicate`. Each operator implements `matches?(actual, expected)`.

| Class | Behavior |
|---|---|
| `EqualOperator` | `actual == expected` |

New operators can be added without touching predicate logic.

## File structure

```
lib/
  file.rb                        # File node (tree structure)
  file_search.rb                 # DFS traversal
  file_search_criteria.rb        # Wraps a predicate for use in search
  operators/
    equal_operator.rb
  predicates/
    simple_predicate.rb
    composite_predicate.rb
    and_predicate.rb
    or_predicate.rb
    not_predicate.rb
test/
  file_search_test.rb
```

## Running tests

```sh
bundle install
bundle exec ruby test/file_search_test.rb
```

## Extending

**New operator** — create a class with `matches?(actual, expected)` and pass an instance to `SimplePredicate`.

**New predicate** — inherit `CompositePredicate`, accept operands in `initialize`, implement `matches?(file)`.
