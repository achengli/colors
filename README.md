<div style="width:100%;height:75px;border-radius:6px;background:linear-gradient(90deg,#E74C3C 0%,#E74C3C 14.28%,#E67E22 14.28%,#E67E22 28.57%,#F1C40F 28.57%,#F1C40F 42.85%,#2ECC71 42.85%,#2ECC71 57.14%,#3498DB 57.14%,#3498DB 71.42%,#9B59B6 71.42%,#9B59B6 85.71%,#1ABC9C 85.71%,#1ABC9C 100%);"></div>

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
print(colorsRed("Error: something went wrong"))$
print(colorsGreen("Success!"))$
print(colorsYellow("Warning: check input"))$
print(colorsCyan("Info: processing..."))$

/* Bright variants */
print(colorsBrightRed("Critical!"))$
print(colorsBrightCyan("Highlighted"))$

/* Styles */
print(colorsBold("Important"))$
print(colorsUnderline("Click here"))$
print(colorsItalic("Note"))$

/* Backgrounds */
print(colorsBgGreen(colorsBlack("  PASS  ")))$
print(colorsBgRed(colorsWhite("  FAIL  ")))$

/* 24-bit true color */
print(colorsRgb(255, 128, 0, "Custom orange"))$
print(colorsRgb(100, 200, 255, "Custom light blue"))$

/* Custom style (any ANSI codes) */
print(colorsStyle("1;4;31", "Bold underlined red"))$

/* Convenience print functions */
colorsPrintRed("This prints red text")$
colorsPrintBold("This prints bold text")$
```

## API Reference

### Foreground colors

| Function | ANSI |
|---|---|
| `colorsRed(t)` | 31 |
| `colorsGreen(t)` | 32 |
| `colorsYellow(t)` | 33 |
| `colorsBlue(t)` | 34 |
| `colorsMagenta(t)` | 35 |
| `colorsCyan(t)` | 36 |
| `colorsWhite(t)` | 37 |
| `colorsBlack(t)` | 30 |

### Bright foreground

| Function | ANSI |
|---|---|
| `colorsBrightRed(t)` | 91 |
| `colorsBrightGreen(t)` | 92 |
| `colorsBrightYellow(t)` | 93 |
| `colorsBrightBlue(t)` | 94 |
| `colorsBrightMagenta(t)` | 95 |
| `colorsBrightCyan(t)` | 96 |
| `colorsBrightWhite(t)` | 97 |
| `colorsBrightBlack(t)` | 90 |

### Styles

| Function | ANSI |
|---|---|
| `colorsBold(t)` | 1 |
| `colorsDim(t)` | 2 |
| `colorsItalic(t)` | 3 |
| `colorsUnderline(t)` | 4 |
| `colorsBlink(t)` | 5 |
| `colorsReverse(t)` | 7 |
| `colorsStrike(t)` | 9 |

### Background colors

| Function | ANSI |
|---|---|
| `colorsBgRed(t)` | 41 |
| `colorsBgGreen(t)` | 42 |
| `colorsBgYellow(t)` | 43 |
| `colorsBgBlue(t)` | 44 |
| `colorsBgMagenta(t)` | 45 |
| `colorsBgCyan(t)` | 46 |
| `colorsBgWhite(t)` | 47 |
| `colorsBgBlack(t)` | 40 |

### Advanced

| Function | Description |
|---|---|
| `colorsRgb(r, g, b, t)` | 24-bit true color foreground |
| `colorsBgRgb(r, g, b, t)` | 24-bit true color background |
| `colorsStyle(codes, t)` | Custom ANSI codes (e.g. `"1;4;31"`) |

### Print helpers

| Function | Equivalent |
|---|---|
| `colorsPrintRed(t)` | `print(colorsRed(t))` |
| `colorsPrintGreen(t)` | `print(colorsGreen(t))` |
| `colorsPrintBlue(t)` | `print(colorsBlue(t))` |
| `colorsPrintYellow(t)` | `print(colorsYellow(t))` |
| `colorsPrintCyan(t)` | `print(colorsCyan(t))` |
| `colorsPrintMagenta(t)` | `print(colorsMagenta(t))` |
| `colorsPrintBold(t)` | `print(colorsBold(t))` |
| `colorsPrintUnderline(t)` | `print(colorsUnderline(t))` |

### Raw codes

For advanced use, the raw escape code strings are exposed:

```maxima
colorsRedCode      /* ESC[31m */
colorsResetCode    /* ESC[0m  */
colorsBoldCode     /* ESC[1m  */
/* ... all codes available as colors#<name>Code */
```

## Examples

### Status badges

```maxima
colorsPrintGreen(colorsBold("[  OK  ]"))$
colorsPrintRed(colorsBold("[ FAIL ]"))$
colorsPrintYellow(colorsBold("[ WARN ]"))$
```

### Colored table headers

```maxima
header(s) := colorsBgBlue(colorsBold(colorsWhite(s)))$
print(header("  NAME  "), header("  VALUE  "))$
```

### Gradient text

```maxima
gradient(s) := block([result: "", i, r, g],
    for i:1 thru slength(s) do (
        r: 255 - i * 20,
        g: i * 20,
        result: sconcat(result, colorsRgb(r, g, 100, charat(s, i)))
    ),
    result
)$
print(gradient("Hello, Maxima!"))$
```

## License

BSD-3 © Yassin Achengli
