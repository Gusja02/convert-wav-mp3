$ffmpegPath = Get-Command ffmpeg.exe -ErrorAction SilentlyContinue

if (-not $ffmpegPath) {
    Write-Host "FFmpeg is not found. Installing FFmpeg using winget..."
    winget install ffmpeg

    $ffmpegPath = Get-Command ffmpeg.exe -ErrorAction SilentlyContinue

    if (-not $ffmpegPath) {
        Write-Host "FFmpeg installation failed. Please install FFmpeg manually."
        Exit 1
    }
}


$work_dir = ".\"	# path\to\folders\

"Getting Folders..."
$folders = Get-ChildItem -Path $work_dir -Directory		# store every folder in a list

foreach ($folder in $folders)
{	
	"Getting .wavs..."
	$wavs_all = Get-ChildItem -Path $folder -File "*.wav"	# store every .wav in the current folder
	
	$wavs =
	@(									# example:
		$wavs_all[0]					# 001.wav
		$wavs_all[1]					# 002.wav
		$wavs_all[$wavs_all.Count - 1]	# 008.wav (last file in the list)
	)

	$year = "0000"	# default values for error handling: TODO
	$month = "00"
	$day = "00"

	$output_path = ".\$($folder)\mp3\"	# example: .\2023.08.27\mp3\

	if (!(Test-Path -Path $output_path))
	{
		mkdir $output_path	# create directory 
	}

	$i = 1

	"Converting wav to mp3..."
	foreach ($wav in $wavs)
	{
		if ($wav.FullName -match "(?<year>\d{4})\.(?<month>\d{2})\.(?<day>\d{2})")	# regex expression that finds the date in the path of the .wav
		{
			$year = $matches.year
			$month = $matches.month
			$day = $matches.day
		}
		else
		{
			"Did not find any date in $($wav.Name)"
			break	# skip to next .wav
		}
		
		$filename = "$($year)$($month)$($day)_$i"	# 20230827_1
		$i++
		
		$in = ".\$($folder)\$($wav)"				# .\2023.08.27\001.wav
		$out = "$($output_path)$($filename).mp3"	# .\2023.08.27\mp3\20230827_1.mp3
													# converted files are stored in a folder "mp3" inside every day
		
		ffmpeg -i $in -vn -ar 44100 -ac 2 -b:a 192k $out	# basic conversion
	}
	"Finished converting."
}

