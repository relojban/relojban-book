# The Relojban Language
[The Relojban Language]: #the-relojban-language

This repository holds the sources of _The Relojban Language_ book, available [here](https://github.com/relojban/relojban.github.io/tree/master/book) in HTML and PDF format. It is one of the main repositories of the Relojban project, a spin-off of [Lojban](https://www.lojban.org).

This repository was built using as foundation the existing [CLL repository](https://github.com/lojban/cll) created by the amazing people over at the Lojban project.

<!--
- relojban-book: _The Relojban Language_ book, the reference grammar and formal specifications of Relojban.
- dictionary (work in progress): The official Relojban dictionary.
- corpus (work in progress): A corpus of Relojban sample texts with their parses.
- relojban-rs (work in progress): An implementation of the language specifications as a Rust library.
- rfcs: The repository for the RFC process used to propose improvements to Relojban.
-->


## Table of Contents
[Table of Contents]: #table-of-contents

  - [General Information]
  - [Building from Sources]
  - [Contributing]
  - [License]


## General information
[General Information]: #general-information

_The Relojban Language_ is written in the [DocBook 5](https://tdg.docbook.org/tdg/5.0/docbook.html) semantic markup language. The sources for the book are stored under [`src/`](src/), one file per chapter.

The metadata tags used are the standard ones from DocBook, with the addition of some customized tags, described in [`README-tags.md`](README-tags.md), that are converted into DocBook-compliant tags as a pre-processing step.

From the DocBook sources, various outputs can be derived. The building process curently supports an XHTML output (with CSS styling) organized as one page per chapter (i.e. "chunked"); an output consisting of a single XHTML file; and a PDF output (created from the XHTML using the Prince PDF generator). These three outputs correspond to the files available for display and download on the [Relojban website](https://www.relojban.org/learn/).


## Building from Sources
[Building from Sources]: #building-from-sources

In order to generate the final outputs from the DocBook sources, a few programs need to be installed on the building host, listed below (the building system assumes that they are available).

- Ruby, with the [Nokogiri](http://www.nokogiri.org/) gem;
- `xmllint` and `xmlto`
- [Prince](https://www.princexml.com/) _(optional for PDF generation, latest version is 13.4 at the time of this writing)_

As an example, the following command will install all the prerequisites on a standard RedHat/Fedora system. Packaging might be different in other distributions.

```shell
sudo dnf install rubygem-nokogiri libxml2 xmlto
sudo dnf install path/to/prince-13.4-1.centos8.x86_64.rpm # (optional for PDF generation)
```

Note that when generating the PDF output, Prince will make use of the fonts available on the system. Therefore the resulting file might be different from the one on the website, depending on the exact set of fonts that Prince can find. To guarantee the same result, make sure the preferred fonts (as indicated in the [CSS](scripts/master.css)) are available on the building host. These are the Linux Libertine fonts (for Serif text), Linux Biolinum fonts (for Sans-serif), the Baekmuk Dotum (Korean) and Ming (Chinese) fonts (the last two are needed just for a couple of examples in the book where Korean and Chinese characters appear).

As an example, the following command will install the preferred fonts on a standard RedHat/Fedora system. Again, availability or packaging might differ with other distributions.

```shell
sudo dnf install linux-libertine-fonts linux-libertine-biolinum-fonts
sudo dnf install baekmuk-ttf-dotum-fonts cjkuni-uming-fonts
```

If the pre-requisites are available, the following command will produce all three outputs (chunked HTML, single-file HTML and PDF) and store them in the `build/` sub-folder.

```shell
make
```

The three targets can also be specified individually:

```shell
make xhtml          # for the chunked HTML version

make xhtml_nochunks # for the single-file HTML version

make pdf            # for the PDF version
```

Note that the build process can also be instructed to make a copy of the final outputs in a separate folder, like this:

```
make COPYDIR=/path/to/final/location/
```


## Contributing
[Contributing]: #contributing

You are very welcome to propose changes and improvements to this repository via GitHub pull requests.

They can be proposed directly from the GitHub interface, which works well for quick fixes. Just follow the [GitHub instruction on editing files in another user's repository](https://help.github.com/articles/editing-files-in-another-user-s-repository/).

Otherwise, you can make a fork and work on a local copy as per standard GitHub workflow:

```shell
# Click the "Fork" button at the top of the page

# Clone your fork to your local machine
git clone https://github.com/_USERNAME_/relojban-book.git
cd relojban-book

# Add the original relojban-book repository to the list of remotes as 'upstream' (to track future changes)
git remote add upstream https://github.com/relojban/relojban-book.git

# Verify the new remote
git remote -v

# Create a new development branch (use an informative name!)
git branch newfeature

# Switch to your new branch
git checkout newfeature

# Publish the branch to your fork
git push --set-upstream origin newfeature

# now edit, build, commit as many times as needed...

# When the changes are done, you can do an interactive rebase to reorganize them into a consistent
# set of commits (note that we rebase only what was not pushed to origin, it is generally not advisable
# to rebase commits that were published)
git checkout newfeature
git rebase -i origin/newfeature

# Get updates from the upstream repository
git fetch upstream

# If there were any new commits, merge master into your development branch and resolve any conflict
git checkout newfeature
git merge origin/master

# Finally, publish your changes
git push

# Now you can go to the page for your fork on GitHub, select your development branch, and click the pull request button.
```

If you are planning to do substantial changes, please take a look at the [RFC process](https://github.com/relojban/rfcs) first!


## License
[License]: #license

See the "Boring Legalities" section in [Chapter 1](src/01-about.xml).

Any content in this repository that is not a derivative work is dedicated to the public domain under the terms of the [Unlicense](UNLICENSE) (see <http://unlicense.org>).

For any contribution intentionally submitted for inclusion to this repository, the submitter agrees to dedicate any and all copyright interest to the public domain under the terms of the same license.
