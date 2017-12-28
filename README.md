# svg-to-jsx
Small opinionated personal tool to convert from SVG files to React JSX functional components. The tool asumes that the target JSX syntax supports ES6. SVGtoJSX was primarily designed to batch export svg icons to embedded SVG React components, so by default all exported files have the sufix "Icon" (Right now this is not optional).

## Prerequisites
SVGtoJSX was developed with Ruby. So go ahead and download Ruby from
[the official site](https://www.ruby-lang.org/en/). If you have trouble visit Ruby's
[own installation guide](https://www.ruby-lang.org/en/downloads/)

This tool uses a couple ruby gems for XML parsing and formatting. Run the following command to install them:

```
$ gem install nokogiri nokogiri-pretty
```

## Usage
On Linux or Unix (MacOS) based systems:

```
Usage: svg-to-jsx.rb <source_path> <output_path> [options]
	-r, --[no-]recursive             Whether to search for files inside subfolders or not. (False by default)
	-p, --[non-]pure                 Export as JSX pure functional components using recompose. (False by default)
	-h, --help                       Show this help message
```

Windows does not recognize Ruby's shebang automatically, the Ruby executable must be appended before the command:

```
> ruby svg-to-jsx.rb <source_path> <output_path> [options]
```

## Built With
* [Ruby](https://www.ruby-lang.org/en/) - The languaje used

## Author
* **Omar Salinas** - [@github](https://github.com/omarsalinas16)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
