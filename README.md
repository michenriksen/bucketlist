# Bucketlist

Bucketlist is a quick project I threw together to find and crawl [Amazon S3] buckets and put all the data into a PostgreSQL database for querying.

## Requirements

Bucketlist requires a recent version of Ruby and the PostgreSQL database system installed.

## Setup

 * Check out the code to a location of your choice and navigate to it in a terminal
 * Install Bundler (unless you already have it) with: `gem install bundler`
 * Install gem dependencies with `bundle install`
 * Create a new PostgreSQL user with: `createuser -s bucketlist --pwprompt` (you might need to `sudo su postgres` first)
 * Create a new PostgreSQL database with: `createdb -O bucketlist bucketlist` (you might need to `sudo su postgres` first)
 * Copy the example configuration file with: `cp config.yml.example config.yml`
 * Edit the settings in `config.yml` to match your setup
 * ???
 * Profit!

## Finding Buckets

Bucketlist finds buckets using a dictionary brute force, a bit like subdomain bruteforcing, so you will need a dictionary of words. The [SecLists] project on GitHub has a good collection of wordlists.

When you have a wordlist, simply run the `bucket_finder` script in a terminal:

    $ bin/bucket_finder path/to/wordlist.lst
     - PRIVATE: https://s3.amazonaws.com/somebucket.backups/
     - PRIVATE: https://s3.amazonaws.com/somebucket.backup/
     - PRIVATE: https://s3.amazonaws.com/backups.somebucket/
     - PRIVATE: https://s3.amazonaws.com/backup.somebucket/
     +  PUBLIC: https://somebucket.dev.s3.amazonaws.com/
     - PRIVATE: https://s3.amazonaws.com/production.somebucket/
     ...

The script will find buckets and store information about them in the database. The script can be stopped at any time. If you run it again with the same wordlist, it will proceed where it left off.

### Bucket name permutations

To maximize discovery, bucket_finder will perform simple permutations on each word in the given wordlist. As an example, if the wordlist contains the word `example`, bucket_finder will check for the existance of any of following buckets:

```
example
example.backup
backup.example
example.backups
backups.example
example.dev
dev.example
example.development
development.example
example.prod
prod.example
example.production
production.example
example.stage
stage.example
example.staging
staging.example
example.test
test.example
example.testing
testing.example
example-backup
backup-example
example-backups
backups-example
example-dev
dev-example
example-development
development-example
example-prod
prod-example
example-production
production-example
example-stage
stage-example
example-staging
staging-example
example-test
test-example
example-testing
testing-example
examplebackup
backupexample
examplebackups
backupsexample
exampledev
devexample
exampledevelopment
developmentexample
exampleprod
prodexample
exampleproduction
productionexample
examplestage
stageexample
examplestaging
stagingexample
exampletest
testexample
exampletesting
testingexample
```

## Crawling Buckets

When buckets have been discovered with `bucket_finder`, the `bucket_crawler` script can be used to crawl the contents of the public buckets and save information about the files to the database:

    $ bin/bucket_crawler
    ├── https://somebucket.dev.s3.amazonaws.com/
    │   ├── PRIVATE: https://somebucket.dev.s3.amazonaws.com/logs/2014-10-11-21-44-41-0DE7B75AC6F56AB6 (276B)
    │   ├── PRIVATE: https://somebucket.dev.s3.amazonaws.com/logs/2014-10-11-22-17-33-0EF1F7575568BC41 (374B)
    │   ├── PRIVATE: https://somebucket.dev.s3.amazonaws.com/logs/2014-10-11-21-30-12-9517510CD37C9D98 (320B)
    ...
    │   ├── PRIVATE: https://somebucket.dev.s3.amazonaws.com/logs/2014-11-07-09-34-44-A23E12B5C822DEB0 (375B)
    │   ├── PRIVATE: https://somebucket.dev.s3.amazonaws.com/logs/2014-11-07-10-51-12-4DB562D370986482 (374B)
    │   ├── PRIVATE: https://somebucket.dev.s3.amazonaws.com/logs/2014-11-07-11-17-56-A58FF2F17296FB3E (375B)
    ├── https://s3.amazonaws.com/someotherbucket/
    │   ├──  PUBLIC: https://s3.amazonaws.com/someotherbucket/3-DuisUtRisusCursus.mp4 (9MB)
    │   ├──  PUBLIC: https://s3.amazonaws.com/someotherbucket/crossdomain.xml (198B)
    │   ├──  PUBLIC: https://s3.amazonaws.com/someotherbucket/6-AeneanLobortisRutrumLoremEuFermentum.mp4 (19MB)
    ...

 The bucket_crawler script will find any public bucket in the database that hasn't been crawled yet, and can be run at any time.

## Browsing the Loot

All the data collected by `bucket_finder` and `bucket_crawler` is stored in a simple database schema and can of course be queried in all kinds of interesting ways with SQL, but Bucketlist also includes a simple web application for browsing the information in a convenient way. You can start the web application with:

    $ bin/webapp
    == Sinatra (v2.0.0) has taken the stage on 3000 for production with backup from Thin
    Thin web server (v1.7.2 codename Bachmanity)
    Maximum connections set to 1024
    Listening on 0.0.0.0:3000, CTRL+C to stop

Now you can browse to [http://localhost:3000/](http://localhost:3000/) and go Bucket spelunking!

## DISCLAIMER

This code is meant for security professionals. I take **no** responsibility and assume no liability for the manner in which this code is used by you.

[Amazon S3]: https://aws.amazon.com/s3/
[SecLists]: https://github.com/danielmiessler/SecLists
