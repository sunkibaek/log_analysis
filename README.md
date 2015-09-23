# Log Analysis

This is an app that loads the given log file and displays simple statistics on them. To run the app:

```bash
$ ruby log_analysis.rb
```

## Structure
`LogLine` parses individual log line. `LogLines` makes collection of `LogLine` objects from the log file. `LogAnalysis` uses a `LogLines` object to output summary. `Array` class has been monkey-patched to have instance methods like mean, median, and mode. Each class has their own corresponding test file.

## Strategies
For each class to have single responsibility, they are divided into multiple short classes. Used dependency injection for extensions and to reduce dependency. Predefined `ENDPOINTS` and iterated through them so that when there are more endpoints, no classes need to be modified.

## Further Development
Monkey-patched `Array` methods are not covering all edge cases. (i.e. when some elements are not integers) They would need further development for production use but suffice for this app.

---

Thanks!
