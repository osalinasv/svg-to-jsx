# svg-to-jsx
Small opinionated personal tool to convert from SVG files to JSX functional components.

## Prerequisites
This tool is developed with Ruby (Rails is not required). So go ahead and download Ruby from
[the official](https://www.ruby-lang.org/en/). If you have trouble visit Ruby's
[own installation guide](https://www.ruby-lang.org/en/downloads/)

This tool uses a couple ruby gems for XML parsing and formatting. Run and install the following global gems:

```
$ gem install nokogiri nokogiri-pretty
```

## Usage
On Linux or Unix (MacOS) based systems:

```
Usage: svg-to-jsx.rb <source_path> <output_path> [options]
	-r, --[no-]recursive             Whether to search for files inside subfolders or not.
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