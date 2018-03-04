
# fonts

Welcome to your new module. A short overview of the generated parts can be found in the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.






#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with fonts](#setup)
    * [What fonts affects](#what-fonts-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with fonts](#beginning-with-fonts)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

Start with a one- or two-sentence summary of what the module does and/or what problem it solves. This is your 30-second elevator pitch for your module. Consider including OS/Puppet version it works with.

You can give more descriptive information in a second paragraph. This paragraph should answer the questions: "What does this module *do*?" and "Why would I use it?" If your module has a range of functionality (installation, configuration, management, etc.), this is the time to mention it.

## Setup

* Load fonts into files/
* Modify manifests/init.pp to your liking with your new fontaloons.
* Ensure $common::staging resolves to a directory on windows, if you are using font removal.

### What fonts affects

* Linux: /usr/local/share/fonts
* Windows: c:/windows/fonts 

### Setup Requirements

Requires a common class with a staging variable for staging windows cleanup scripts.

$common::staging


### Beginning with fonts

include fonts

Fonts::Install{'MyAwesomeFont.otf', dir => $dir}

## Usage

This section is where you describe how to customize, configure, and do the fancy stuff with your module here. It's especially helpful if you include usage examples and code samples for doing things with your module.

## Reference

Users need a complete list of your module's classes, types, defined types providers, facts, and functions, along with the parameters for each. You can provide this list either via Puppet Strings code comments or as a complete list in the README Reference section.

* If you are using Puppet Strings code comments, this Reference section should include Strings information so that your users know how to access your documentation.

* If you are not using Puppet Strings, include a list of all of your classes, defined types, and so on, along with their parameters. Each element in this listing should include:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

## Limitations

* Windows
* Linux

## Development

CL's welcome.

## Release Notes/Contributors/Etc. **Optional**

See windows deployment notes. There is currently a windows font removal bug, in that it is not completely imdempotent.

If you want to use an alternative font directory, "Font Links" must be enabled. This is applied at the current user
level, so you'll need to be able to modify the registry according:

[HKEY_USERS\<SID>\Software\Microsoft\Windows NT\CurrentVersion\Font Management]
"InstallAsLink"=dword:00000001

Font links created before this is set will have to be remade.
