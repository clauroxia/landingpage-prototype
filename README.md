# Capstone Project -Micolet

Project created as a technical challenge.

## Installation

### Required technologies:

Ruby: 2.7.5

Rails: 7.0.2.3

PostgreSQL: 12.9

### Steps to Install this project:

After clone this repository to download the gems and dependencies needed

```bash
  bundle install
```

To start your PostgreSQL server

```bash
  sudo service PostgreSQL start
```

To create the databases, run the migrations and seed the preferences by default

```bash
  rails db:create
  rails db:migrate
  rails db:seed
```

Create a .env file and add the Environment Variables

```bash
  touch .env
```

To start your server

```bash
  rails s
```

## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

Creating an account on https://www.abstractapi.com/ :

```bash
  `ABSTRACT_API_KEY`
```

You can get these on any google account with two-steps verification activated.
The first one as the name suggest is the account username(everything before the "@")
and the second one is generated by google on "App Passwords" where You should choose "Other"
as "Select App" and put any name to the app.

```bash
  `GOOGLE_USERNAME`
  `GOOGLE_APP_PWD`
```

## Custom Configurations

#### ".rubocop.yml" a customized version of rubocop was used in this project which one have the following configs:

AllCops:

- NewCops: enable
- Exclude:
  - "db/\*_/_"
  - "script/\*_/_"
  - "bin/\*_/_"
  - "node*modules/\**/\_"

Style/StringLiterals:
EnforcedStyle: double_quotes

Style/FrozenStringLiteralComment:
Enabled: false

Style/Documentation:
Enabled: false

Metrics/MethodLength:
Max: 20

Metrics/AbcSize:
Max: 30

Style/GlobalVars:
Enabled: false

Style/WordArray:
MinSize: 10

Style/ClassVars:
Enabled: false

HasAndBelongsToMany:
Enabled: false

Layout/LineLength:
Max: 100
IgnoredPatterns: ['\s*#']

Metrics/BlockLength:
Exclude: - config/**/\* - spec/**/\*

Lint/AmbiguousBlockAssociation:
Exclude: - spec/\*_/_

## To add another language to i18n

Go to

```bash
 ./config/application.rb
```

Add the corresponding local on line 39, for instance:

```bash
 config.i18n.available_locales = %I[es en ru]
```

Create a yaml file with the same structure than the other on

```bash
 ./config/locales
```
- Remember that the file name must be the local, e.g. in the case of french, "fr.yml".
- Optional you can add a logo for the language, on ./app/assets/images local must be the name, e.g. "fr.png".

Available_locales https://github.com/svenfuchs/rails-i18n

## Running Tests

To run tests, run the following command

```bash
  rspec
```

## Authors

- [@ClaudiaBerrios](https://www.linkedin.com/in/claudia-berrios-939265b9/)
- [@RubenSantillan](https://www.linkedin.com/in/sandro-santillan/)
- [@AustinLinares](https://www.linkedin.com/in/austin-linares/)
