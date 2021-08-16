#!/bin/sh
echo "Running NadekoBot"
root=$(pwd)

if hash dotnet 2>/dev/null
then
	echo "Dotnet installed."
else
	echo "Dotnet is not installed. Please install dotnet."
	exit 1
fi

cd "$root/nadekobot/output"
echo "Running NadekoBot. Please wait."
dotnet run NadekoBot.dll
echo "Done"

cd "$root"
rm "$root/n-arn.sh"
exit 0
