import contextlib
from typing import TextIO

import bibtexparser
import sys 
import argparse
from pathlib import Path

def get_field(entry, field):
    return [f for f in entry.fields if f.key == field][0].value

def sort_by_year(entry) -> int:
    try:
        r = int(get_field(entry, "year"))
    except ValueError:
        r = 0
    return r

def author_string(authors: list[str]) -> str:
    out = ""
    for author in authors.split("and"):
        sn, fn = author.split(",")
        if sn.strip() == "Clarke":
            out  = out + f"**{fn.strip()} {sn.strip()}**, "
        else:
            out = out + f"{fn.strip()} {sn.strip()}, "
    return out[:-2]

def format_entry(entry) -> str:
    match entry.entry_type:
        case "article":
            authors = author_string(get_field(entry, "author"))
            year = get_field(entry, "year")
            title = get_field(entry, "title")
            journal = get_field(entry, "journal")
            url = get_field(entry, "url")
            if year == "In Press":
                string = f"{authors} ({year}). {title}. *{journal}*."
            else:
                string = f"{authors} ({year}). {title}. *{journal}*. [`{url}`]({url})"
        case "phdthesis":
            authors = author_string(get_field(entry, "author"))
            year = get_field(entry, "year")
            title = get_field(entry, "title")
            school = get_field(entry, "school")
            url = get_field(entry, "url")
            string = f"{authors} ({year}). {title}. *{school}*. [`{url}`]({url})"
        case _:
            sys.exit(f"Unknown entry type {entry.entry_type} in {entry.key}")
    return string

HEADER = """---
text_align_right: false
show_title_as_headline: true
---

A list of my publications can also be found on my [google scholar](https://scholar.google.com/citations?user=DH2wyRoAAAAJ&hl=en
) profile. 
You might also be interested in my [CV](/cv.pdf).

"""

def get_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
            description="Convert a BibTeX file into a Hugo markdown publications page."
        )
    parser.add_argument("input", type=Path, help="path to the .bib file")
    parser.add_argument(
        "output",
        type=Path,
        nargs="?",
        help="path to the output markdown file (default: stdout)",
    )
    args = parser.parse_args()
    return args

def load_entries(filename: Path):
    library = bibtexparser.parse_string(filename.read_text(encoding="utf-8"))
    entries = library.entries
    entries.sort(key=sort_by_year, reverse=True)
    return entries

@contextlib.contextmanager
def open_output_file(filename: None | Path):
    if filename is None:
        try: 
            yield sys.stdout
        finally:
            pass  
    else:
        filename.parent.mkdir(parents=True, exist_ok=True)
        with filename.open("w", encoding="utf-8") as out:
            yield out

def main():
    args = get_args()
    entries = load_entries(args.input)

    with open_output_file(args.output) as publication_list:
        publication_list.write(HEADER)
        for entry in entries:
            publication_list.write(format_entry(entry) + "\n\n")

if __name__ == "__main__":
    main()

