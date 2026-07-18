# colors — Terminal colors for Maxima

ANSI terminal color support for Maxima output. Provides escape codes,
colorization functions, and print helpers.

## Installation

```sh
maxpack install achengli/colors
```

Or in Maxima:

```maxima
maxpack#mInstall("achengli/colors")$
maxpack#mImport("colors")$
```

## Usage

```maxima
load("colors")$

/* Basic colors */
print(colors#red("Error: something went wrong"))$
print(colors#green("Success!"))$
print(colors#yellow("Warning: check input"))$
print(colors#cyan("Info: processing..."))$

/* Bright variants */
print(colors#brightRed("Critical!"))$
print(colors#brightCyan("Highlighted"))$

/* Styles */
print(colors#bold("Important"))$
print(colors#underline("Click here"))$
print(colors#italic("Note"))$

/* Backgrounds */
print(colors#bgGreen(colors#black("  PASS  ")))$
print(colors#bgRed(colors#white("  FAIL  ")))$

/* 24-bit true color */
print(colors#rgb(255, 128, 0, "Custom orange"))$
print(colors#rgb(100, 200, 255, "Custom light blue"))$

/* Custom style (any ANSI codes) */
print(colors#style("1;4;31", "Bold underlined red"))$

/* Convenience print functions */
colors#printRed("This prints red text")$
colors#printBold("This prints bold text")$
```

## API Reference

### Foreground colors

| Function | ANSI |
|---|---|
| `colors#red(t)` | 31 |
| `colors#green(t)` | 32 |
| `colors#yellow(t)` | 33 |
| `colors#blue(t)` | 34 |
| `colors#magenta(t)` | 35 |
| `colors#cyan(t)` | 36 |
| `colors#white(t)` | 37 |
| `colors#black(t)` | 30 |

### Bright foreground

| Function | ANSI |
|---|---|
| `colors#brightRed(t)` | 91 |
| `colors#brightGreen(t)` | 92 |
| `colors#brightYellow(t)` | 93 |
| `colors#brightBlue(t)` | 94 |
| `colors#brightMagenta(t)` | 95 |
| `colors#brightCyan(t)` | 96 |
| `colors#brightWhite(t)` | 97 |
| `colors#brightBlack(t)` | 90 |

### Styles

| Function | ANSI |
|---|---|
| `colors#bold(t)` | 1 |
| `colors#dim(t)` | 2 |
| `colors#italic(t)` | 3 |
| `colors#underline(t)` | 4 |
| `colors#blink(t)` | 5 |
| `colors#reverse(t)` | 7 |
| `colors#strike(t)` | 9 |

### Background colors

| Function | ANSI |
|---|---|
| `colors#bgRed(t)` | 41 |
| `colors#bgGreen(t)` | 42 |
| `colors#bgYellow(t)` | 43 |
| `colors#bgBlue(t)` | 44 |
| `colors#bgMagenta(t)` | 45 |
| `colors#bgCyan(t)` | 46 |
| `colors#bgWhite(t)` | 47 |
| `colors#bgBlack(t)` | 40 |

### Advanced

| Function | Description |
|---|---|
| `colors#rgb(r, g, b, t)` | 24-bit true color foreground |
| `colors#bgRgb(r, g, b, t)` | 24-bit true color background |
| `colors#style(codes, t)` | Custom ANSI codes (e.g. `"1;4;31"`) |

### Print helpers

| Function | Equivalent |
|---|---|
| `colors#printRed(t)` | `print(colors#red(t))` |
| `colors#printGreen(t)` | `print(colors#green(t))` |
| `colors#printBlue(t)` | `print(colors#blue(t))` |
| `colors#printYellow(t)` | `print(colors#yellow(t))` |
| `colors#printCyan(t)` | `print(colors#cyan(t))` |
| `colors#printMagenta(t)` | `print(colors#magenta(t))` |
| `colors#printBold(t)` | `print(colors#bold(t))` |
| `colors#printUnderline(t)` | `print(colors#underline(t))` |

### Raw codes

For advanced use, the raw escape code strings are exposed:

```maxima
colors#redCode      /* ESC[31m */
colors#resetCode    /* ESC[0m  */
colors#boldCode     /* ESC[1m  */
/* ... all codes available as colors#<name>Code */
```

## Examples

### Status badges

```maxima
colors#printGreen(colors#bold("[  OK  ]"))$
colors#printRed(colors#bold("[ FAIL ]"))$
colors#printYellow(colors#bold("[ WARN ]"))$
```

### Colored table headers

```maxima
header(s) := colors#bgBlue(colors#bold(colors#white(s)))$
print(header("  NAME  "), header("  VALUE  "))$
```

### Gradient text

```maxima
gradient(s) := block([result: "", i, r, g],
    for i:1 thru slength(s) do (
        r: 255 - i * 20,
        g: i * 20,
        result: sconcat(result, colors#rgb(r, g, 100, charat(s, i)))
    ),
    result
)$
print(gradient("Hello, Maxima!"))$
```

## License

BSD-3 © Yassin Achengli
