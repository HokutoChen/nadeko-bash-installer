#!/bin/sh
root=$(pwd)

# Legend:
# (A) - Database related operations
# (B) - Aliases related operations
# (C) - Strings related operations

# remove old backup
rm -rf nadekobot_old 1>/dev/null 2>&1

# make a new backup
mv -fT nadekobot nadekobot_old 1>/dev/null 2>&1

# clone new version
git clone -b v3 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot
cd nadekobot

# build
export DOTNET_CLI_TELEMETRY_OPTOUT=1
dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o output/

# go back
cd "$root"

# move creds from old to new
mv -f nadekobot_old/output/creds.yml nadekobot/output/creds.yml 1>/dev/null 2>&1

# on update, strings will be new version, user will have to manually re-add his strings after each update
# as updates may cause big number of strings to become obsolete, changed, etc
# however, old user's strings will be backed up to strings_old

# (C) backup new strings to reverse rewrite
rm -rf nadekobot/output/data/strings_old 1>/dev/null 2>&1 # remove old backup preemptively to avoid copying what will get overwritten with new backup
mv -f nadekobot/output/data/strings nadekobot/output/data/strings_new 1>/dev/null 2>&1

# (B) backup new aliases to reverse rewrite
rm -rf nadekobot/output/data/aliases_old.yml 1>/dev/null 2>&1
mv -f nadekobot/output/data/aliases.yml nadekobot/output/data/aliases_new.yml 1>/dev/null 2>&1

# (A) move old database
mv -f nadekobot_old/output/data/NadekoBot.db nadekobot/output/data/NadekoBot.db 1>/dev/null 2>&1

# move old data folder contents (and overwrite)
cp -RT nadekobot_old/output/data/ nadekobot/output/data/ 1>/dev/null 2>&1

# (B) backup old aliases
mv -f nadekobot/output/data/aliases.yml nadekobot/output/data/aliases_old.yml 1>/dev/null 2>&1
# (B) restore new aliases
mv -f nadekobot/output/data/aliases_new.yml nadekobot/output/data/aliases.yml 1>/dev/null 2>&1

# (C) backup old strings
mv -rf nadekobot/output/data/strings nadekobot/output/data/strings_old 1>/dev/null 2>&1
# (C) restore new strings
mv -rf nadekobot/output/data/strings_new nadekobot/output/data/strings 1>/dev/null 2>&1

cd "$root"
rm "$root/n-install.sh"
exit 0